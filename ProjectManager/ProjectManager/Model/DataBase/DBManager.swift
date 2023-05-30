//
//  DBManager.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/30.
//

import Foundation

final class DBManager: DatabaseManagable {
    
    private var database: DatabaseManagable? = LocalDBManager(type: TaskObject.self)
    
    func changeDatabase(isConnect: Bool) {
        if isConnect {
            database = RemoteDBManager()
        } else {
            database = LocalDBManager(type: TaskObject.self)
        }
    }
    
    func create(object: Storable) {
        database?.create(object: object)
    }
    
    func fetch(_ completion: @escaping (Result<[Storable], Error>) -> Void) {
        database?.fetch(completion)
    }
    
    func delete(object: Storable) {
        database?.delete(object: object)
    }
    
    func update(object: Storable) {
        database?.update(object: object)
    }
}
