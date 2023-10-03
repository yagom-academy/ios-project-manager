//
//  DIContainer.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import Foundation

final class DIContainer {
    
    static let keyboard = KeyboardManager()
    
    static let kanbanViewModel: KanbanViewModel = {
        let repository = RealmTaskRepository()
        let useCases = TaskUseCases(taskRepository: repository)
        let viewModel = KanbanViewModel(useCases: useCases)
        
        return viewModel
    }()
    
    static let historyViewModel: HistoryViewModel = {
        let repository = RealmHistoryRepository()
        let useCases = HistoryUseCases(historyRepository: repository)
        let viewModel = HistoryViewModel(useCases: useCases)
        
        return viewModel
    }()
}
