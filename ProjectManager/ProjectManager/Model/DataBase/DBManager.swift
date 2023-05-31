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
    private lazy var localDB = LocalDBManager<TaskObject>(errorHanlder: errorHandler)
    private lazy var remoteDB = RemoteDBManager(errorHandler: errorHandler)
    
    func changeDatabase(isConnect: Bool, syncedObjects: [Storable]?) {
        if isConnect {
            database = remoteDB
        } else {
            database = localDB
            
            guard let objects = syncedObjects else { return }
            
            remoteDB.synchronizeObjects(objects)
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
