//
//  TodoHistoryTableViewModel.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/19.
//

import Foundation
import Combine

protocol TodoHistoryTableViewModelInput {
    
}

protocol TodoHistoryTableViewModelOutput {
    var items: AnyPublisher<[TodoHistory], Never> { get }
}

protocol TodoHistoryTableViewModelable: TodoHistoryTableViewModelInput, TodoHistoryTableViewModelOutput {}

final class TodoHistoryTableViewModel: TodoHistoryTableViewModelable {
    
    // MARK: - Output
    var items: AnyPublisher<[TodoHistory], Never> {
        return Just([TodoHistory(id: "asdf", title: "asdf", createdAt: Date()),TodoHistory(id: "asdf2", title: "asdf2", createdAt: Date())]).eraseToAnyPublisher()
    }
    
    private let useCase: TodoHistoryUseCaseable
    
    init(useCase: TodoHistoryUseCaseable) {
        self.useCase = useCase
    }
}
