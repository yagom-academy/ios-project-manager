//
//  UserRepository.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import Foundation

protocol UserRepository {
    func fetchUser() -> User?
    func login(_ user: User)
    func logout()
    
    var isFirstLaunch: Bool { get }
}
