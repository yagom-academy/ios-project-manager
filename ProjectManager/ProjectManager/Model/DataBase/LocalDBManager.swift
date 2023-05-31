//
//  LocalDBManager.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/29.
//

import RealmSwift

final class LocalDBManager<T: Object>: DatabaseManagable {
    
    private let realm: Realm
    var errorHandler: ((Error) -> Void)?
    
    init?(errorHanlder: ((Error) -> Void)?) {
        self.errorHandler = errorHanlder
        
        do {
            self.realm = try Realm()
        } catch {
            return nil
        }
    }
    
    func create(object: Storable) {
        let dbObject = object.changedToDatabaseObject
        
        try? realm.write({
            realm.add(dbObject, update: .all)
        })
    }
    
    func fetch(_ completion: @escaping (Result<[Storable], Error>) -> Void) {
        let dbObjects = realm.objects(T.self)
        let objects = dbObjects.map { dbObject in
            return Task.convertToStorable(dbObject)
        }
        let objectList = Array(objects).compactMap { storable in
            return storable
        }
        
        completion(.success(Array(objectList)))
    }
    
    func delete(object: Storable) {
        guard let dbObject = realm.object(ofType: T.self, forPrimaryKey: object.id) else {
            return
        }
        
        try? realm.write({
            realm.delete(dbObject)
        })
    }
    
    func update(object: Storable) {
        guard realm.object(ofType: T.self, forPrimaryKey: object.id) != nil else {
            return
        }
        
        delete(object: object)
        create(object: object)
    }
}
