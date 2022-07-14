//
//  Todo.swift
//  ProjectManager
//
//  Created by Eddy on 2022/07/05.
//

import Foundation

struct Todo {
    var todoListItemStatus: TodoListItemStatus
    let identifier: UUID
    let title: String
    let description: String
    let date: Date
    
    init(
        todoListItemStatus: TodoListItemStatus = .todo,
        identifier: UUID = UUID(),
        title: String = "",
        description: String = "",
        date: Date = Date()
    ) {
        self.todoListItemStatus = todoListItemStatus
        self.identifier = identifier
        self.title = title
        self.description = description
        self.date = date
    }
}
