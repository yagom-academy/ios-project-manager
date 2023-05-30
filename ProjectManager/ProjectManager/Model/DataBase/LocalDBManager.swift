//
//  LocalDBManager.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/29.
//

import RealmSwift

final class LocalDBManager: DatabaseManagable {
    
    private let realm: Realm
    private let type: Object.Type
    
    init?(type: Object.Type) {
        do {
            self.realm = try Realm()
            self.type = type
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
        let dbObjects = realm.objects(type.self)
        let objects = dbObjects.map { dbObject in
            return Task.convertToStorable(dbObject)
        }
        let objectList = Array(objects).compactMap { storable in
            return storable
        }
        
        completion(.success(Array(objectList)))
    }
    
    func delete(object: Storable) {
        guard let dbObject = realm.object(ofType: type.self, forPrimaryKey: object.id) else {
            return
        }
        
        try? realm.write({
            realm.delete(dbObject)
        })
    }
    
    func update(object: Storable) {
        guard realm.object(ofType: type.self, forPrimaryKey: object.id) != nil else {
            return
        }
        
        delete(object: object)
        create(object: object)
    }
}
