//
//  DefaultTodoListRepository.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine

final class TodoListRepository {
    private unowned let storage: Storageable
        
    init(storage: Storageable) {
        self.storage = storage
    }
}

extension TodoListRepository: TodoListRepositorible {
    func create(_ item: Todo) -> AnyPublisher<Void, StorageError> {
        return storage.create(item)
    }
    
    func read() -> CurrentValueSubject< [Todo], Never> {
        return storage.read()
    }
    
    func update(_ item: Todo) -> AnyPublisher<Void, StorageError> {
        return storage.update(item)
    }
    
    func delete(item: Todo) -> AnyPublisher<Void, StorageError> {
        return storage.delete(item)
    }
    
    func deleteLastItem() -> AnyPublisher<Void, StorageError> {
        guard let lastItem = storage.read().value.last else {
            return Fail<Void, StorageError>(error: .deleteFail).eraseToAnyPublisher()
        }
        
        return storage.delete(lastItem)
    }
}
