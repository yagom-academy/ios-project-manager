//
//  DIContainer.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import Foundation

final class DIContainer {
    static let keyboard = KeyboardManager()
    
    static private let sharedUserRepository = LocalUserRepository()
    
    static let taskManager: TaskManager = {
        let localRepository = LocalTaskRepository()
        let remoteRepository = RemoteTaskRepository()
        
        let taskUseCases = TaskUseCases(
            localRepository: localRepository,
            remoteRepository: remoteRepository,
            userRepository: sharedUserRepository
        )
        
       return TaskManager(taskUseCases: taskUseCases)
    }()
    
    static let userManager: UserManager = {
        let useCases = UserUseCases(
            userRepository: sharedUserRepository
        )
        
        return UserManager(userUseCases: useCases)
    }()
    
    static let historyManager: HistoryManager = {
        let repository = LocalHistoryRepository()
        let useCases = HistoryUseCases(historyRepository: repository)
        
        return HistoryManager(historyUseCases: useCases)
    }()
    
    
}
