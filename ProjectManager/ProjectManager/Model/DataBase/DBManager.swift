//
//  DBManager.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/30.
//

import Foundation

final class DBManager: DatabaseManagable {
    
    var errorHandler: ((Error) -> Void)?
    
    private var database: DatabaseManagable?
    private var localDB: LocalDBManager<TaskObject>?
    
    func changeDatabase(isConnect: Bool, syncedObjects: [Storable]?) {
        guard let objects = syncedObjects else { return }
        
        if isConnect {
            database = RemoteDBManager(errorHandler: errorHandler)
            localDB = LocalDBManager<TaskObject>(errorHandler: errorHandler)
        } else {
            database = nil
            localDB = LocalDBManager<TaskObject>(errorHandler: errorHandler)
        }
    }
    
    func create(object: Storable) {
        guard let database = database else { return }
        database.create(object: object)
        localDB?.create(object: object)
    }
    
    func fetch(_ completion: @escaping (Result<[Storable], Error>) -> Void) {
        database?.fetch(completion)
        localDB?.fetch(completion)
    }
    
    func delete(object: Storable) {
        guard let database = database else { return }
        database.delete(object: object)
        localDB?.delete(object: object)
    }
    
    func update(object: Storable) {
        guard let database = database else { return }
        database.update(object: object)
        localDB?.update(object: object)
    }
}
