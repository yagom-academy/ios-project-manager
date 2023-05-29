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
    
    func create<DAO: Object>(_ data: DAO) {
        guard let realm = realm else { return }
        
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func read<DAO: Object>(type: DAO.Type, id: UUID) -> DAO? {
        guard let realm = realm else { return nil }
        
        let object = realm.object(ofType: type, forPrimaryKey: id)
        
        return object
    }
    
    func readAll<DAO: Object>(type: DAO.Type) -> [DAO]? {
        guard let realm = realm else { return nil }
        
        return Array(realm.objects(type))
    }
    
    func update<DTO: DataTransferObject, DAO: Object & DataAcessObject>(_ data: DTO, type: DAO.Type) {
        guard let realm = realm else { return }
        
        do {
            try realm.write {
                guard let object = read(type: type, id: data.id),
                      let data = data as? DAO.TaskType  else { return }
                
                object.updateValue(task: data)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func delete<DAO: Object>(type: DAO.Type, id: UUID) {
        guard let realm = realm,
              let object = read(type: type, id: id) else { return }
        
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
