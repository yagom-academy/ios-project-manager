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
    private var basicDB: DatabaseManagable?
    
    init(basicDB: DatabaseManagable? = nil) {
        self.basicDB = basicDB
    }
    
    func changeDatabase(isConnect: Bool, syncedObjects: [Storable]?) {
        guard let objects = syncedObjects else { return }
        
        if isConnect {
            database = RemoteDBManager(errorHandler: errorHandler)
        } else {
            database = nil
        }
    }
    
    func create(object: Storable) {
        guard let database = database else { return }
        database.create(object: object)
        basicDB?.create(object: object)
    }
    
    func fetch(_ completion: @escaping (Result<[Storable], Error>) -> Void) {
        basicDB?.fetch(completion)
    }
    
    func delete(object: Storable) {
        guard let database = database else { return }
        database.delete(object: object)
        basicDB?.delete(object: object)
    }
    
    func update(object: Storable) {
        guard let database = database else { return }
        database.update(object: object)
        basicDB?.update(object: object)
    }
}
