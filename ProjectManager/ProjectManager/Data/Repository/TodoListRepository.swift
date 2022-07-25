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
    private var cancellableBag = Set<AnyCancellable>()
    
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
    
    func synchronizeDatabase() {
        if UserDefaults.standard.object(forKey: "isFirstLogin") != nil {
            todoRemoteStorage.backup(todoLocalStorage.read().value)
        } else {
            todoRemoteStorage.read()
                .sink { _ in
                    
                } receiveValue: { [weak self] items in
                    items.forEach { item in
                        _ = self?.todoLocalStorage.create(item)
                    }
                }
                .store(in: &cancellableBag)
        }
        
        UserDefaults.standard.set(true, forKey: "isFirstLogin")
    }
}
