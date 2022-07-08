//
//  MemoryTodoListStorege.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/08.
//

import Foundation

protocol TodoListStorege {
    func read() -> [TodoModel]
    func save(to data: TodoModel)
}

final class MemoryTodoListStorege {
    private var memoryStorege: [TodoModel] = TodoModel.makeDummy()
}

extension MemoryTodoListStorege: TodoListStorege {
    func read() -> [TodoModel] {
        return memoryStorege
    }
    
    func save(to data: TodoModel) {
        memoryStorege.insert(data, at: 0)
    }
}
