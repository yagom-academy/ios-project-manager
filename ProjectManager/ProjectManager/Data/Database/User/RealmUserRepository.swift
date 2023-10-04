//
//  RealmUserRepository.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import Foundation
import RealmSwift

final class RealmUserRepository: UserRepository {
    
    let realm: Realm = {
        do {
            return try Realm()
        } catch {
            fatalError("could not load REALM")
        }
    }()
    
    func fetchUser() -> User? {
        if let userObject = realm.objects(RealmUserObject.self).first {
            return userObject.toDomain()
        } else {
            return nil
        }
    }
    
    func save(_ user: User) {
        try? realm.write {
            realm.add(user.toObject())
        }
    }
    
    func update(id: UUID, new user: User) {
        try? realm.write {
            let userObject = realm.object(ofType: RealmUserObject.self, forPrimaryKey: id)
            userObject?.email = user.email
        }
    }
    
    func logout(_ user: User) {
        if let user = realm.object(ofType: RealmUserObject.self, forPrimaryKey: user.id) {
            try? realm.write {
                realm.delete(user)
            }
        }        
    }
}
