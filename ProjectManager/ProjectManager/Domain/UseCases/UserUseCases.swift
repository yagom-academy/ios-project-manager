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
        let user = getUser()
        
        if user != nil {
            return false
        } else {
            let user = User()
            userRepository.save(user)
            
            return true
        }
    }
    
    func getUser() -> User? {
        userRepository.fetchUser()
    }
    
    func registerEmail(_ email: String) {
        guard var user = getUser() else {
            let user = User(email: email)
            userRepository.save(user)
            return
        }
        
        user.email = email        
        userRepository.update(id: user.id, new: user)
    }
    
    func logout(_ user: User) {
        userRepository.logout(user)
    }
}
