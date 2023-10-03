//
//  DIContainer.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import Foundation

final class DIContainer {
    
    static let keyboard = KeyboardManager()
    
    static let kanbanViewModel: KanbanViewModel =  {
        let repository = RealmTaskRepository()
        let useCase = TaskUseCases(taskRepository: repository)
        let viewModel = KanbanViewModel(useCase: useCase)
        
        return viewModel
    }()
}
