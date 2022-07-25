//
//  NetworkStorageManager.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/25.
//

import FirebaseDatabase

protocol NetworkStorageManagerable {
    func create()
    func read()
    func update()
    func delete()
}

struct NetworkStorageManager: NetworkStorageManagerable {
    private let database = Database.database()
    
    init() {
        database.isPersistenceEnabled = true
    }
    
    func create() {
        
    }
    
    func read() {
    }
    
    func update() {
    
    }
    
    func delete() {
        
    }
}
