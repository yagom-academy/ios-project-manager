//
//  TodoHistoryTableViewModel.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/19.
//

import Foundation
import Combine

protocol TodoHistoryTableViewModelInput {
    // empty
}

protocol TodoHistoryTableViewModelOutput {
    var items: CurrentValueSubject<[TodoHistory], Never> { get }
}

protocol TodoHistoryTableViewModelable: TodoHistoryTableViewModelInput, TodoHistoryTableViewModelOutput {}

final class TodoHistoryTableViewModel: TodoHistoryTableViewModelable {
    
    // MARK: - Output
    
    private let historyUseCase: TodoHistoryUseCaseable
    
    let items: CurrentValueSubject<[TodoHistory], Never>

    init(historyUseCase: TodoHistoryUseCaseable) {
        self.historyUseCase = historyUseCase
        self.items = historyUseCase.todoHistoriesPublisher()
    }
}
