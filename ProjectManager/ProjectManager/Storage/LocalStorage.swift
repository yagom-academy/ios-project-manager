//
//  LocalStorage.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/20.
//

import RealmSwift

protocol LocalStorageable {
    func readList(_ type: ListType) -> [ListItem]
    func createItem(_ item: ListItem, _ completion: @escaping (Result<[ListItem], Error>) -> Void)
    func updateItem(_ item: ListItem, _ completion: @escaping (Result<[ListItem], Error>) -> Void)
    func deleteItem(_ item: ListItem, _ completion: @escaping (Result<[ListItem], Error>) -> Void)
}

final class LocalStorage: Object, LocalStorageable {
    private let todoList = List<ListItemDTO>()
    private let doingList = List<ListItemDTO>()
    private let doneList = List<ListItemDTO>()
    
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
    
    func createItem(_ item: ListItem, _ completion: @escaping (Result<[ListItem], Error>) -> Void) {
        guard let realm = try? Realm() else {
            return
        }
        
        if realm.objects(LocalStorage.self).isEmpty {
            let listModel = LocalStorage()
            listModel.todoList.append(item.convertedItem)
            
            try? realm.write {
                realm.add(listModel)
                
                completion(.success(readList(item.type)))
            }
        } else {
            try? realm.write {
                selectListModel(item.type).append(item.convertedItem)
                completion(.success(readList(item.type)))
            }
        }
    }
    
    func updateItem(_ item: ListItem, _ completion: @escaping (Result<[ListItem], Error>) -> Void) {
        guard let realm = try? Realm() else {
            return
        }
        
        let itemModel = selectListModel(item.type)
            .filter(NSPredicate(format: "id = %@", item.id)).first
        
        try? realm.write {
            itemModel?.title = item.title
            itemModel?.deadline = item.deadline
            itemModel?.body = item.body
            completion(.success(readList(item.type)))
        }
    }
    
    func deleteItem(_ item: ListItem, _ completion: @escaping (Result<[ListItem], Error>) -> Void) {
        guard let realm = try? Realm() else {
            return
        }
        
        guard let itemModel = selectListModel(item.type)
            .filter(NSPredicate(format: "id = %@", item.id)).first else {
            return
        }
        
        try? realm.write {
            realm.delete(itemModel)
            completion(.success(readList(item.type)))
        }
    }
}
