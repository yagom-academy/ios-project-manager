//
//  TodoListUseCase.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine

protocol TodoListUseCaseable {
    func create(_ item: Todo) -> AnyPublisher<Void, StorageError>
    func read() -> CurrentValueSubject<[Todo], Never>
    func update(_ item: Todo) -> AnyPublisher<Void, StorageError>
    func delete(item: Todo) -> AnyPublisher<Void, StorageError>
}

final class TodoListUseCase: TodoListUseCaseable {
    private let repository: TodoListRepositorible
    
    init(repository: TodoListRepositorible) {
        self.repository = repository
    }
    
    func create(_ item: Todo) -> AnyPublisher<Void, StorageError> {
        return repository.create(item)
    }
    
    func read() -> CurrentValueSubject<[Todo], Never> {
        return repository.read()
    }
    
    func update(_ item: Todo) -> AnyPublisher<Void, StorageError> {
        return repository.update(item)
    }
    
    func delete(item: Todo) -> AnyPublisher<Void, StorageError> {
        return repository.delete(item: item)
    }
}
