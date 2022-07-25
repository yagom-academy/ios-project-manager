//
//  NetworkStorageManager.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/25.
//

import FirebaseDatabase

protocol NetworkStorageManagerable {
    func create(_ item: ListItemDTO)
    func read()
    func updateItem(_ item: ListItemDTO)
    func delete()
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
        database.reference().child(item.type).child(item.id).setValue(object)
    }
    
    func read() {
    }

    func updateItem(_ item: ListItemDTO) {
        let object: [String: Any] = [
            "title": item.title,
            "body": item.body,
            "deadline": item.deadline.timeIntervalSince1970,
            "type": item.type,
            "id": item.id
        ]
        database.reference().child(item.type).child(item.id).updateChildValues(object)
    }
    
    func delete() {
        
    }
}
