//
//  Todo.swift
//  ProjectManager
//
//  Created by Eddy on 2022/07/05.
//

import Foundation

private enum Const {
    static let empty = ""
}

struct Todo {
    var todoListItemStatus: TodoListItemStatus
    let identifier: UUID
    let title: String
    let description: String
    let date: Date
    
    init(
        todoListItemStatus: TodoListItemStatus = .todo,
        identifier: UUID = UUID(),
        title: String = Const.empty,
        description: String = Const.empty,
        date: Date = Date()
    ) {
        self.todoListItemStatus = todoListItemStatus
        self.identifier = identifier
        self.title = title
        self.description = description
        self.date = date
    }
    
    func convertRealmTodo() -> RealmTodo {
        return RealmTodo(
            todoListItemStatus: self.todoListItemStatus,
            identifier: self.identifier,
            title: self.title,
            body: self.description,
            date: self.date
        )
    }
}
