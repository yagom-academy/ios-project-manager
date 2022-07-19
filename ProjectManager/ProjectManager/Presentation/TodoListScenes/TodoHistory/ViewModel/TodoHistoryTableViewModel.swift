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
    var items: AnyPublisher<[TodoHistory], Never> { get set }
}

protocol TodoHistoryTableViewModelable: TodoHistoryTableViewModelInput, TodoHistoryTableViewModelOutput {}

final class TodoHistoryTableViewModel: TodoHistoryTableViewModelable {
    
    // MARK: - Output
    var items: AnyPublisher<[TodoHistory], Never>
            
    init(items: AnyPublisher<[TodoHistory], Never>) {
        self.items = items
    }
}
