//
//  UserManager.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/05.
//

import Foundation

final class UserManager: ObservableObject {
    private let userUseCases: UserUseCases
    
    @Published var isFirstLaunch: Bool
    @Published var user: User?
    
    @Published var inputEmail: String = ""
    @Published var isRegisterFormOn: Bool
    
    init(userUseCases: UserUseCases) {
        self.userUseCases = userUseCases
        self.user = userUseCases.fetchUser()
        
        let isFirstLaunch = userUseCases.checkFirstLaunch()
        self.isFirstLaunch = isFirstLaunch
        self.isRegisterFormOn = isFirstLaunch
    }
    
    func register() {
        userUseCases.registerEmail(inputEmail)
        user = userUseCases.fetchUser()
        isRegisterFormOn = false
        turnOffFirstLaunch()
    }
    
    func pushback() {
        isRegisterFormOn = false
        turnOffFirstLaunch()
    }
    
    func logout() {
        userUseCases.logout()
        user = nil
        isRegisterFormOn = false
    }
    
    private func turnOffFirstLaunch() {
        UserDefaults.standard.set(true, forKey: RealUserLocalRepository.LaunchKey)
    }
}
