//
//  TodoHistoryTableViewModel.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/19.
//

import Foundation

protocol TodoHistoryTableViewModelInput {
    
}

protocol TodoHistoryTableViewModelOutput {
    
}

protocol TodoHistoryTableViewModelable: TodoHistoryTableViewModelInput, TodoHistoryTableViewModelOutput {}

final class TodoHistoryTableViewModel: TodoHistoryTableViewModelable {
    private let useCase: TodoHistoryUseCaseable
    
    init(useCase: TodoHistoryUseCaseable) {
        self.useCase = useCase
    }
}
