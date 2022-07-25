//
//  TodoHistoryViewModel.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/25.
//

import Foundation

protocol HistoryViewModelOutput {
    
}

protocol HistoryViewModel: HistoryViewModelOutput {}

final class DefaultTodoHistoryViewModel: HistoryViewModel {
    private let useCase: TodoListUseCase
    
    init(useCase: TodoListUseCase) {
        self.useCase = useCase
    }
}
