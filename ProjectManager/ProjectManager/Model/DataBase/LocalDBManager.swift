//
//  LocalDBManager.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/29.
//

import RealmSwift

final class LocalDBManager<T: Object>: DatabaseManagable {
    
    private var realm: Realm? {
        do {
            let realm = try Realm()
            
            return realm
        } catch {
            errorHandler?(DatabaseError.databaseConfigureError)
        }
        
        return nil
    }
    var errorHandler: ((Error) -> Void)?
    
    init(errorHandler: ((Error) -> Void)?) {
        self.errorHandler = errorHandler
    }
    
    func create(object: Storable) {
        let dbObject = object.changedToDatabaseObject
        
        do {
            try realm?.write({
                realm?.add(dbObject, update: .all)
            })
        } catch {
            errorHandler?(DatabaseError.createError)
        }
    }
    
    func fetch(_ completion: @escaping (Result<[Storable], Error>) -> Void) {
        guard let dbObjects = realm?.objects(T.self) else {
            completion(.failure(DatabaseError.fetchedError))
            return
        }
        let objects = dbObjects.map { dbObject in
            return Task.convertToStorable(dbObject)
        }
        let objectList = Array(objects).compactMap { storable in
            return storable
        }
        
        completion(.success(Array(objectList)))
    }
    
    func delete(object: Storable) {
        guard let dbObject = realm?.object(ofType: T.self, forPrimaryKey: object.id) else {
            errorHandler?(DatabaseError.deletedError)
            return
        }
        
        do {
            try realm?.write({
                realm?.delete(dbObject)
            })
        } catch {
            errorHandler?(DatabaseError.deletedError)
        }
    }
    
    func update(object: Storable) {
        guard realm?.object(ofType: T.self, forPrimaryKey: object.id) != nil else {
            errorHandler?(DatabaseError.updatedError)
            return
        }
        
        delete(object: object)
        create(object: object)
    }
    
    private func deleteAll() {
        do {
            try realm?.write {
                realm?.deleteAll()
            }
        } catch {
            errorHandler?(DatabaseError.deletedError)
        }
    }
}
