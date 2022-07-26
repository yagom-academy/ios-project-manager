//
//  MockTodoListRepository.swift
//  ProjectManagerTests
//
//  Created by 조민호 on 2022/07/21.
//

import Foundation
import Combine

@testable import ProjectManager

final class MockTodoListRepository: TodoListRepositorible {
    var createCallCount = 0
    var readCallCount = 0
    var updateCallCount = 0
    var deleteCallCount = 0
    var synchronizeDatabaseCallCount = 0
    
    func create(_ item: Todo) -> AnyPublisher<Void, StorageError> {
        createCallCount += 1
        return Empty().eraseToAnyPublisher()
    }
    
    func todosPublisher() -> CurrentValueSubject<[Todo], Never> {
        readCallCount += 1
        return CurrentValueSubject<[Todo], Never>([])
    }
    
    func update(_ item: Todo) -> AnyPublisher<Void, StorageError> {
        updateCallCount += 1
        return Empty().eraseToAnyPublisher()
    }
    
    func delete(item: Todo) -> AnyPublisher<Void, StorageError> {
        deleteCallCount += 1
        return Empty().eraseToAnyPublisher()
    }
    
    func synchronizeDatabase() {
        synchronizeDatabaseCallCount += 1
    }
    
}
