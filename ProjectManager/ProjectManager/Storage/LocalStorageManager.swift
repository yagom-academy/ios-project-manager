//
//  LocalStorage.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/20.
//

import RealmSwift

protocol LocalStorageManagerable {
    func readList(_ type: ListType) -> [ListItem]
    func createItem(_ item: ListItem) throws -> [ListItem]
    func updateItem(_ item: ListItem) throws -> [ListItem]
    func deleteItem(_ item: ListItem) throws -> [ListItem]
}

final class LocalStorageManager: LocalStorageManagerable {
    private let networkStorageManager: NetworkStorageManagerable
    private let realm = try? Realm()
    
    init(_ networkStorageManager: NetworkStorageManagerable) {
        self.networkStorageManager = networkStorageManager
    }
    
    private func selectListModel(_ type: ListType) -> List<ListItemDTO> {
        guard let realm = try? Realm() else {
            return List<ListItemDTO>()
        }
        
        guard let listModel = realm.objects(LocalStorage.self).first else {
            return List<ListItemDTO>()
        }
        
        switch type {
        case .todo:
            return listModel.todoList
        case .doing:
            return listModel.doingList
        case .done:
            return listModel.doneList
        }
    }
    
    func readList(_ type: ListType) -> [ListItem] {
        let list: [ListItem] = selectListModel(type)
            .compactMap { $0.convertedItem }
            .sorted { $0.deadline < $1.deadline }
        return list
    }
    
    func createItem(_ item: ListItem) throws -> [ListItem] {
        guard let realm = realm else {
            return []
        }
        
        do {
            if realm.objects(LocalStorage.self).isEmpty {
                let listModel = LocalStorage()
                listModel.todoList.append(item.convertedItem)
                
                try realm.write {
                    realm.add(listModel)
                }
            } else {
                try realm.write {
                    selectListModel(item.type).append(item.convertedItem)
                }
            }
            networkStorageManager.create(item.convertedItem)
        } catch {
            throw StorageError.creatError
        }
        
        return readList(item.type)
    }
    
    func updateItem(_ item: ListItem) throws -> [ListItem] {
        let itemModel = selectListModel(item.type)
            .filter(NSPredicate(format: "id = %@", item.id)).first
        
        do {
            try realm?.write {
                itemModel?.title = item.title
                itemModel?.deadline = item.deadline
                itemModel?.body = item.body
            }
            networkStorageManager.updateItem(item.convertedItem)
        } catch {
            throw StorageError.updateError
        }
        
        return readList(item.type)
    }
    
    func deleteItem(_ item: ListItem) throws -> [ListItem] {
        guard let itemModel = selectListModel(item.type)
            .filter(NSPredicate(format: "id = %@", item.id)).first else {
            return []
        }
        
        do {
            try realm?.write {
                realm?.delete(itemModel)
            }
        } catch {
            throw StorageError.deleteError
        }
        
        return readList(item.type)
    }
}
