//
//  DefaultTodoListRepository.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine

final class TodoListRepository {
    private unowned let todoLocalStorage: LocalStorageable
    private unowned let todoRemoteStorage: RemoteStorageable
        
    init(todoLocalStorage: LocalStorageable, todoRemoteStorage: RemoteStorageable) {
        self.todoLocalStorage = todoLocalStorage
        self.todoRemoteStorage = todoRemoteStorage
    }
}

extension TodoListRepository: TodoListRepositorible {
    func create(_ item: Todo) -> AnyPublisher<Void, StorageError> {
        return todoLocalStorage.create(item)
    }
    
    func read() -> CurrentValueSubject< [Todo], Never> {
        return todoLocalStorage.read()
    }
    
    func update(_ item: Todo) -> AnyPublisher<Void, StorageError> {
        return todoLocalStorage.update(item)
    }
    
    func delete(item: Todo) -> AnyPublisher<Void, StorageError> {
        return todoLocalStorage.delete(item)
    }
    
    func synchronize() {
        if true {
            todoRemoteStorage.read().value.forEach {
                todoLocalStorage.create($0)
            }
        } else {
            todoRemoteStorage.backup(todoLocalStorage.read().value)
        }
    }
}
