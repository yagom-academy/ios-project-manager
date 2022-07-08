//
//  DefaultTodoListRepository.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/08.
//

import Foundation

final class DefaultTodoListRepository {
    private let storege: TodoListStorege
    
    init(storege: TodoListStorege) {
        self.storege = storege
    }
}

extension DefaultTodoListRepository: TodoListRepository {
    func read() -> [TodoModel] {
        return storege.read()
    }
    
    func save(to data: TodoModel) {
        storege.save(to: data)
    }
}
