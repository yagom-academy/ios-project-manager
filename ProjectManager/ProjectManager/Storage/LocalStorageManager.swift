//
//  LocalStorage.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/20.
//

import RealmSwift

protocol LocalStorageManagerable {
    func readList(_ type: ListType) -> [ListItem]
    func createItem(_ item: ListItem, _ completion: @escaping (Result<[ListItem], StorageError>) -> Void)
    func updateItem(_ item: ListItem, _ completion: @escaping (Result<[ListItem], StorageError>) -> Void)
    func deleteItem(_ item: ListItem, _ completion: @escaping (Result<[ListItem], StorageError>) -> Void)
}

final class LocalStorageManager: LocalStorageManagerable {
    private let realm = try? Realm()
    
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
    
    func createItem(_ item: ListItem, _ completion: @escaping (Result<[ListItem], StorageError>) -> Void) {
        guard let realm = realm else {
            return
        }
        
        if realm.objects(LocalStorage.self).isEmpty {
            let listModel = LocalStorage()
            listModel.todoList.append(item.convertedItem)
            
            do {
                try realm.write {
                    realm.add(listModel)
                    
                    completion(.success(readList(item.type)))
                }
            } catch {
                completion(.failure(StorageError.creatError))
            }
        } else {
            do {
                try realm.write {
                    selectListModel(item.type).append(item.convertedItem)
                    completion(.success(readList(item.type)))
                }
            } catch {
                completion(.failure(StorageError.creatError))
            }
        }
    }
    
    func updateItem(_ item: ListItem, _ completion: @escaping (Result<[ListItem], StorageError>) -> Void) {
        let itemModel = selectListModel(item.type)
            .filter(NSPredicate(format: "id = %@", item.id)).first
        
        do {
            try realm?.write {
                itemModel?.title = item.title
                itemModel?.deadline = item.deadline
                itemModel?.body = item.body
                completion(.success(readList(item.type)))
            }
        } catch {
            completion(.failure(StorageError.updateError))
        }
    }
    
    func deleteItem(_ item: ListItem, _ completion: @escaping (Result<[ListItem], StorageError>) -> Void) {
        guard let itemModel = selectListModel(item.type)
            .filter(NSPredicate(format: "id = %@", item.id)).first else {
            return
        }
        
        do {
            try realm?.write {
                realm?.delete(itemModel)
                completion(.success(readList(item.type)))
            }
        } catch {
            completion(.failure(StorageError.deleteError))
        }
    }
}
