//
//  DefaultTodoListRepository.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/08.
//

import Foundation
import RxSwift
import RxRelay

final class DefaultTodoListRepository {
    private let storage: TodoListStorege
    
    init(storage: TodoListStorege) {
        self.storage = storage
    }
}

extension DefaultTodoListRepository: TodoListRepository {
    var errorObserver: PublishRelay<TodoError> {
        return storage.errorObserver
    }
    
    func read() -> BehaviorSubject<[TodoModel]> {
        return storage.read()
    }
    
    func save(to data: TodoModel) {
        storage.save(to: data)
    }
    
    func delete(index: Int) {
        storage.delete(index: index)
    }
}
