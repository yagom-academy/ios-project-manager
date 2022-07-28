//
//  TodoHistoryUseCase.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/19.
//

import Foundation
import Combine

protocol TodoHistoryUseCaseable {
    func create(_ item: TodoHistory)
    var todoHistoriesPublisher: CurrentValueSubject<HistoryStorageState, Never> { get }
    func delete(item: TodoHistory)
}

final class TodoHistoryUseCase: TodoHistoryUseCaseable {
    private let repository: TodoHistoryRepositorible
    
    init(repository: TodoHistoryRepositorible) {
        self.repository = repository
    }
    
    func create(_ item: TodoHistory) {
        repository.create(item)
    }
    
    var todoHistoriesPublisher: CurrentValueSubject<HistoryStorageState, Never> {
        return repository.todoHistoriesPublisher
    }
    
    func delete(item: TodoHistory) {
        repository.delete(item: item)
    }
}
