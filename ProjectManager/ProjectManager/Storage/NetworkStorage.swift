//
//  NetworkStorageManager.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/25.
//

import FirebaseDatabase

protocol NetworkStorageManagerable {
    func create(_ item: ListItemDTO)
    func read(_ completion: @escaping (Result<[ListItem], StorageError>) -> Void)
    func updateItem(_ item: ListItemDTO)
    func deleteItem(_ item: ListItemDTO)
}

struct NetworkStorageManager: NetworkStorageManagerable {
    private let database = Database.database()
    
    init() {
        database.isPersistenceEnabled = true
    }
    
    func create(_ item: ListItemDTO) {
        let object: [String: Any] = [
            "title": item.title,
            "body": item.body,
            "deadline": item.deadline.timeIntervalSince1970,
            "type": item.type,
            "id": item.id
        ]
        database.reference().child(item.id).setValue(object)
    }
    
    func read(_ completion: @escaping (Result<[ListItem], StorageError>) -> Void) {
        database.reference().getData { error, snapshot in
            guard error == nil else {
                completion(.failure(StorageError.readError))
                return
            }
            guard let allItems = snapshot?.value as? [String: Any] else {
                return
            }
            
            let list: [ListItem] = allItems.compactMap {
                guard let item = $0.value as? [String: Any] else {
                    return nil
                }
                
                return ListItem(title: item["title"] as? String ?? "",
                                body: item["body"] as? String ?? "",
                                deadline: Date(timeIntervalSince1970: item["deadline"] as? Double ?? 0),
                                type: ListType(rawValue: item["type"] as? String ?? "") ?? .todo,
                                id: item["id"] as? String ?? "")
            }
            completion(.success(list))
        }
    }

    func updateItem(_ item: ListItemDTO) {
        let object: [String: Any] = [
            "title": item.title,
            "body": item.body,
            "deadline": item.deadline.timeIntervalSince1970,
            "type": item.type,
            "id": item.id
        ]
        database.reference().child(item.id).updateChildValues(object)
    }
    
    func deleteItem(_ item: ListItemDTO) {
        database.reference().child(item.id).removeValue()
    }
}
