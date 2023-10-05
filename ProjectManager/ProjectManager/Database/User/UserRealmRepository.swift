//
//  LocalUserRepository.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import Foundation
import RealmSwift

final class UserRealmRepository: UserRepository {
    
    private let realm: Realm = {
        do {
            return try Realm()
        } catch {
            fatalError("could not load REALM")
        }
    }()
    
    private let userDefaults = UserDefaults.standard
    static let LaunchKey = "Launch"
    
    var isFirstLaunch: Bool {
        if userDefaults.bool(forKey: Self.LaunchKey) == false {
            return true
        } else {
            return false
        }
    }
    
    func fetchUser() -> User? {
        if let userObject = realm.objects(UserObject.self).first {
            return userObject.toDomain()
        } else {
            return nil
        }
    }
    
    func login(_ user: User) {
        try? realm.write {
            let objects = realm.objects(UserObject.self)
            realm.delete(objects)
            realm.add(user.toObject())
        }
    }
    
    func logout() {        
        try? realm.write {
            let objects = realm.objects(UserObject.self)
            realm.delete(objects)
        }
    }
}
