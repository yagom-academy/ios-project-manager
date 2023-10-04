//
//  UserRepository.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import Foundation

protocol UserRepository {
    func fetchUser() -> User?
    func save(_ user: User)
    func update(id: UUID, new user: User)
    func logout(_ user: User)
}
