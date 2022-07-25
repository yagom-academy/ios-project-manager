//
//  NetworkStorage.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/25.
//

import FirebaseDatabase

struct NetworkStorageManager {
    private let database = Database.database()
    
    init() {
        database.isPersistenceEnabled = true
    }
}
