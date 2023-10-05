//
//  UserMapper.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import Foundation

extension UserObject {
    func toDomain() -> User {
        User(id: self.id, email: self.email)
    }
}

extension User {
    func toObject() -> UserObject {
        UserObject(id: self.id, email: self.email)
    }
}
