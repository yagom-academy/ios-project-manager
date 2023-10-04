//
//  DIContainer.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import Foundation

final class DIContainer {
    
    static let appState: AppState = {
        let repository = RealmUserRepository()
        let useCases = UserUseCases(userRepository: repository)
        
        return AppState(userUseCases: useCases)
    }()
    
    static let keyboard = KeyboardManager()
    
    static let kanbanViewModel: KanbanViewModel = {
        let localRepository = RealmTaskRepository()
        let remoteRepository = FireStoreTaskRepository()
        let useCases = TaskUseCases(
            appState: appState,
            localRepository: localRepository,
            remoteRepository: remoteRepository
        )
        let viewModel = KanbanViewModel(useCases: useCases)
        
        return viewModel
    }()
    
    static let historyViewModel: HistoryViewModel = {
        let repository = RealmHistoryRepository()
        let useCases = HistoryUseCases(historyRepository: repository)
        let viewModel = HistoryViewModel(useCases: useCases)
        
        return viewModel
    }()
    
    static let loginViewModel: LoginViewModel = {
        return LoginViewModel(appState: appState)        
    }()
}
