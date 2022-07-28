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
    private let isFirstLogin: Bool
    private var cancellableBag = Set<AnyCancellable>()
    
    init(todoLocalStorage: LocalStorageable, todoRemoteStorage: RemoteStorageable,
         isFirstLogin: Bool
    ) {
        self.todoLocalStorage = todoLocalStorage
        self.todoRemoteStorage = todoRemoteStorage
        self.isFirstLogin = isFirstLogin
    }
}

extension TodoListRepository: TodoListRepositorible {
    func create(_ item: Todo) {
        todoLocalStorage.create(item)
    }
    
    func todosPublisher() -> CurrentValueSubject<LocalStorageState, Never> {
        return todoLocalStorage.todosPublisher()
    }
    
    func update(_ item: Todo) {
        todoLocalStorage.update(item)
    }
    
    func delete(item: Todo) {
        todoLocalStorage.delete(item)
    }
    
    func synchronizeDatabase() {
        if isFirstLogin {
            switch todoLocalStorage.todosPublisher().value {
            case .success(let items):
                todoRemoteStorage.backup(items)
            case .failure(let _):
                break
            }
        } else {
            todoRemoteStorage.todosPublisher()
                .sink { _ in
                    
                } receiveValue: { [weak self] items in
                    items.forEach { item in
                        _ = self?.todoLocalStorage.create(item)
                    }
                }
                .store(in: &cancellableBag)
            
            UserDefaults.standard.set(true, forKey: "isFirstLogin")
        }
    }
}
