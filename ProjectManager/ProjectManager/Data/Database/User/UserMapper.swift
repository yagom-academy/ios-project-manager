//
//  UserMapper.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import Foundation

extension RealmUserObject {
    func toDomain() -> User {
        User(id: self.id, email: self.email)
    }
}

extension User {
    func toObject() -> RealmUserObject {
        RealmUserObject(id: self.id, email: self.email)
    }
}
