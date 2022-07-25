//
//  TodoHistoryViewModel.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/25.
//

import Foundation

protocol TodoHistoryViewModelOutput {
    
}

protocol TodoHistoryViewModel: TodoHistoryViewModelOutput {}

final class DefaultTodoHistoryViewModel: TodoHistoryViewModel {
    private let useCase: TodoListUseCase
    
    init(useCase: TodoListUseCase) {
        self.useCase = useCase
    }
}
