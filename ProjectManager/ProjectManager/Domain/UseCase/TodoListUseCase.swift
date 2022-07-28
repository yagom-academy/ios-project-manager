//
//  TodoListUseCase.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine

protocol TodoListUseCaseable {
    func create(_ item: Todo)
    func todosPublisher() -> CurrentValueSubject<LocalStorageState, Never>
    func update(_ item: Todo)
    func delete(item: Todo)
    func synchronizeDatabase()
}

final class TodoListUseCase: TodoListUseCaseable {
    private let repository: TodoListRepositorible
    
    init(repository: TodoListRepositorible) {
        self.repository = repository
    }
    
    func create(_ item: Todo) {
        repository.create(item)
    }
    
    func todosPublisher() -> CurrentValueSubject<LocalStorageState, Never> {
        return repository.todosPublisher()
    }
    
    func update(_ item: Todo) {
        repository.update(item)
    }
    
    func delete(item: Todo) {
        repository.delete(item: item)
    }
    
    func synchronizeDatabase() {
        repository.synchronizeDatabase()
    }
}
