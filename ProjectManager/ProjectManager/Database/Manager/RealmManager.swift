//
//  ProjectManager.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 05/07/2022.
//

import Foundation
import RealmSwift

protocol RealmManagerable {
    func create<T: Object>(_ data: T) throws
    func read<T: Object>(_ nsPredicate: NSPredicate) -> [T]
    func readAll<T: Object>() -> [T]
    func update<T: Object>(updatedData: T) throws
    func delete<T: Object>(_ data: T) throws
    func deleteAll() throws
}

final class RealmManager: RealmManagerable {
    private(set) static var shared: RealmManagerable?
    private let realm: Realm
    
    private init(realm: Realm) {
        self.realm = realm
    }
    
    static func configure(realm: Realm? = nil) {
        if let realm = realm {
            RealmManager.shared = RealmManager(realm: realm)
        } else {
            guard let newRealm = try? Realm() else { return }
            RealmManager.shared = RealmManager(realm: newRealm)
        }
    }
    
    func create<T: Object>(_ data: T) throws {
        try realm.write {
            realm.add(data)
        }
    }
    
    func read<T: Object>(_ nsPredicate: NSPredicate) -> [T] {
        let results = realm.objects(T.self).filter(nsPredicate)
        return Array(results)
    }
    
    func readAll<T: Object>() -> [T] {
        let data = realm.objects(T.self)
        return Array(data)
    }
    
    func update<T: Object>(updatedData: T) throws {
        try realm.write({
            realm.add(updatedData, update: .modified)
        })
    }
    
    func delete<T: Object>(_ data: T) throws {
        try realm.write({
            realm.delete(data)
        })
    }
    
    func deleteAll() throws {
        try realm.write({
            realm.deleteAll()
        })
    }
}

#if DEBUG
// 테스트 파일에서 Realm() 을사용하는것이 안되서 다음과 같이 테스트용 init을 만들었습니다.
extension RealmManager {
    convenience init() {
        let realm = try! Realm()
        self.init(realm: realm)
    }
}
#endif
