//
//  RealmManager.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/26.
//

import Foundation
import RealmSwift

final class RealmManager {
    let realm = try? Realm()
    
    func create<T: Object>(_ data: T) {
        guard let realm = realm else { return }

        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func read<T: Object>(type: T.Type, id: UUID) -> T? {
        guard let realm = realm else { return nil }
        
        let object = realm.object(ofType: type, forPrimaryKey: id)
        
        return object
    }
    
    func readAll<T: Object>(type: T.Type) -> Results<T>? {
        guard let realm = realm else { return nil }
        
        return realm.objects(type)
    }
    
    func update<T: Object>(_ data: T) {
        guard let realm = realm else { return }
        
        do {
            try realm.write {
                realm.add(data, update: .modified)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func delete<T: Object>(_ data: T) {
        guard let realm = realm else { return }
        
        do {
            try realm.write {
                realm.delete(data)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
