//
//  TodoDatabaseManager.swift
//  ProjectManager
//
//  Created by Baek on 2022/09/19.
//

import Foundation

protocol TodoDatabaseManager {
    func create(todoData: TodoModel)
    func read() -> [TodoModel]
    func update(updateTodoData: TodoModel) -> Bool
    func delete(deleteTodoData: UUID) -> Bool
}
