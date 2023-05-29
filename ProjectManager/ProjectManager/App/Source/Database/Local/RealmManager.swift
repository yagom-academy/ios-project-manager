//
//  RealmManager.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/26.
//

import Foundation
import RealmSwift

final class RealmManager {
    private let realm = try? Realm()
    
    func create<T: Object & Identifying>(_ data: T) {
        guard let realm = realm else { return }

        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func read<T: Object & Identifying>(type: T.Type, id: UUID) -> T? {
        guard let realm = realm else { return nil }
        
        let object = realm.object(ofType: type, forPrimaryKey: id)
        
        return object
    }
    
    func readAll<T: Object & Identifying>(type: T.Type) -> [T]? {
        guard let realm = realm else { return nil }
        
        return Array(realm.objects(type))
    }
    
    func update<T: Object & Identifying>(_ data: T) {
        guard let realm = realm else { return }
        
        do {
            try realm.write {
                realm.add(data, update: .modified)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func delete<T: Object & Identifying>(_ data: T) {
        guard let realm = realm,
              let object = read(type: T.self, id: data.id) else { return }
        
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteAll() {
        guard let realm = realm else { return }
        
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
