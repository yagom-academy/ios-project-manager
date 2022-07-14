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
}
