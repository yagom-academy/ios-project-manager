//
//  Todo.swift
//  ProjectManager
//
//  Created by Eddy on 2022/07/05.
//

import Foundation

struct Todo {
    let todoListItemStatus: TodoListItemStatus
    let identifier: UUID = UUID()
    let title: String
    let description: String
    let date: Date
}
