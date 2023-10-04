//
//  UserUseCases.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import Foundation

final class UserUseCases {
    
    private let userRepository: UserRepository
    
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository       
    }
    
    func checkFirstLaunch() -> Bool {
        userRepository.isFirstLaunch
    }
    
    func fetchUser() -> User? {
        return userRepository.fetchUser()
    }
    
    func registerEmail(_ email: String) {
        let user = User(email: email)
        userRepository.login(user)
    }
    
    func logout() {
        userRepository.logout()
    }
}
