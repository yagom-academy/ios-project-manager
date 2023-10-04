//
//  User.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import Foundation

struct User {
    let id: UUID
    var email: String?
    
    init(id: UUID = .init(), email: String? = nil) {
        self.id = id
        self.email = email
    }
}
