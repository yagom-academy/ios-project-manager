//
//  LoginViewModel.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import Foundation

final class LoginViewModel: ObservableObject {
    
    private let appState: AppState
    
    @Published var inputEmail: String
    @Published var isRegisterAlertOn: Bool
    @Published var isConnectedRemoteServer: Bool
    
    init(appState: AppState) {
        self.appState = appState
        self.inputEmail = ""
        
        if appState.isFirstLaunch {
            self.isRegisterAlertOn = true
        } else {
            self.isRegisterAlertOn = false
        }
        
        self.isConnectedRemoteServer = appState.isConnectedRemoteServer
    }
    
    var email: String {
        appState.user?.email ?? ""
    }
    
    func register() {
        appState.registerEmail(inputEmail)
        isConnectedRemoteServer = true
        isRegisterAlertOn = false
    }
    
    func openRegisterAlert() {
        isRegisterAlertOn = true
    }
    
    func logout() {
        appState.logout()
        isRegisterAlertOn = false
        isConnectedRemoteServer = false
    }
}
