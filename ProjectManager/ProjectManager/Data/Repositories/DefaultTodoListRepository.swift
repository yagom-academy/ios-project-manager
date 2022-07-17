//
//  DefaultTodoListRepository.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/08.
//

import Foundation
import RxSwift

final class DefaultTodoListRepository {
    private let storage: TodoListStorege
    
    init(storage: TodoListStorege) {
        self.storage = storage
    }
}

extension DefaultTodoListRepository: TodoListRepository {
    func read() -> BehaviorSubject<[TodoModel]> {
        return storage.read()
    }
    
    func save(to data: TodoModel) {
        storage.save(to: data)
    }
}
