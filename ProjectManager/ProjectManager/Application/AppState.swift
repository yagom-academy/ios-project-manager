//
//  AppState.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import Foundation

final class AppState {
    private let userUseCases: UserUseCases
    
    var isConnectedRemoteServer: Bool
    var isFirstLaunch: Bool
    var user: User?
    
    init(userUseCases: UserUseCases) {
        self.userUseCases = userUseCases
        
        self.isFirstLaunch = userUseCases.checkFirstLaunch()
        self.user = userUseCases.getUser()
        self.isConnectedRemoteServer = user?.email == nil ? false : true
    }
    
    func registerEmail(_ email: String) {
        userUseCases.registerEmail(email)
        isConnectedRemoteServer = true
        user?.email = email
    }
    
    func logout() {
        if let user = self.user {
            userUseCases.logout(user)
            self.user = nil
        }
    }
}
