//
//  ProjectManager.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 05/07/2022.
//

import Foundation
import RealmSwift

protocol RealmManagerable {
    func create<T: Object>(project: T) throws
    func read<T: Object>(predicate: NSPredicate) -> T?
    func readAll<T: Object>() -> [T]
    func update<T: Object>(project: T) throws
    func delete<T: Object>(project: T) throws
}

final class RealmManager: RealmManagerable {
    private let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func create<T: Object>(project: T) throws {
        try realm.write {
            realm.add(project)
        }
    }
    
    func read<T: Object>(predicate: NSPredicate) -> T? {
        return realm.objects(T.self)
                    .filter(predicate)
                    .first
    }
    
    func readAll<T: Object>() -> [T] {
        let data = realm.objects(T.self)
        return Array(data)
    }
    
    func update<T: Object>(project: T) throws {
        try realm.write({
            realm.add(project, update: .modified)
        })
    }
    
    func delete<T: Object>(project: T) throws {
        try realm.write({
            realm.delete(project)
        })
    }
}
