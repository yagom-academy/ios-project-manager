//
//  LocalStorage.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/20.
//

import RealmSwift

protocol LocalStorageManagerable {
    func setList(_ completion: @escaping (Result<Void, StorageError>) -> Void)
    func readList(_ type: ListType) -> [ListItem]
    func readHistory() -> [History]
    func createItem(_ item: ListItem) throws
    func updateItem(_ item: ListItem) throws
    func deleteItem(_ item: ListItem) throws
    func addHistory(title: String) throws
}

final class LocalStorageManager: LocalStorageManagerable {
    private let networkStorageManager: NetworkStorageManagerable
    private let realm: Realm
    
    init(networkStorageManager: NetworkStorageManagerable, realm: Realm) {
        self.networkStorageManager = networkStorageManager
        self.realm = realm
    }
    
    func setList(_ completion: @escaping (Result<Void, StorageError>) -> Void) {
        networkStorageManager.read { result in
            switch result {
            case .success(let list):
                do {
                    try self.deleteAll()
                    list.forEach {
                        do {
                            try self.createItem($0)
                        } catch {
                            completion(.failure(StorageError.readError))
                        }
                    }
                } catch {
                    completion(.failure(StorageError.deleteError))
                }
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func convertedItem(_ item: ListItem) -> ListItemDTO {
        let itemModel = ListItemDTO()
        itemModel.title = item.title
        itemModel.body = item.body
        itemModel.deadline = item.deadline
        itemModel.type = item.type.rawValue
        itemModel.id = item.id
        
        return itemModel
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
            .compactMap {
                ListItem(title: $0.title,
                         body: $0.body,
                         deadline: $0.deadline,
                         type: ListType(rawValue: $0.type) ?? .todo,
                         id: $0.id)
            }
            .sorted { $0.deadline < $1.deadline }
        return list
    }
    
    func readHistory() -> [History] {
        guard let listModel = realm.objects(LocalStorage.self).first else {
            return []
        }
        return listModel.history.compactMap { $0 }
    }
    
    func addHistory(title: String) throws {
        do {
            try realm.write {
                guard let listModel = realm.objects(LocalStorage.self).first else {
                    return
                }
                
                let history = History()
                history.title = title
                
                let historyStorage = listModel.history
                historyStorage.append(history)
                
                if historyStorage.count > 15 {
                    historyStorage.removeFirst()
                }
            }
        } catch{
            throw StorageError.historyError
        }
    }
    
    func createItem(_ item: ListItem) throws {
        do {
            if realm.objects(LocalStorage.self).isEmpty {
                let listModel = LocalStorage()
                switch item.type {
                case .todo:
                    listModel.todoList.append(convertedItem(item))
                case .doing:
                    listModel.doingList.append(convertedItem(item))
                case .done:
                    listModel.doneList.append(convertedItem(item))
                }
                
                
                try realm.write {
                    realm.add(listModel)
                }
            } else {
                try realm.write {
                    selectListModel(item.type).append(convertedItem(item))
                }
            }
            networkStorageManager.create(convertedItem(item))
        } catch {
            throw StorageError.creatError
        }
    }
    
    func updateItem(_ item: ListItem) throws {
        let itemModel = selectListModel(item.type)
            .filter(NSPredicate(format: "id = %@", item.id)).first
        
        do {
            try realm.write {
                itemModel?.title = item.title
                itemModel?.deadline = item.deadline
                itemModel?.body = item.body
            }
            networkStorageManager.updateItem(convertedItem(item))
        } catch {
            throw StorageError.updateError
        }
    }
    
    func deleteItem(_ item: ListItem) throws {
        guard let itemModel = selectListModel(item.type)
            .filter(NSPredicate(format: "id = %@", item.id)).first else {
            return
        }
        
        do {
            try realm.write {
                realm.delete(itemModel)
            }
            networkStorageManager.deleteItem(convertedItem(item))
        } catch {
            throw StorageError.deleteError
        }
    }
    
    private func deleteAll() throws {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            throw StorageError.deleteError
        }
    }
}
