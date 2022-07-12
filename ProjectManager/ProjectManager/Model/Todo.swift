//
//  Todo.swift
//  ProjectManager
//
//  Created by Eddy on 2022/07/05.
//

import Foundation

struct Todo {
    let status: TodoListItemStatus
    let identifier: UUID = UUID()
    let title: String
    let description: String
    let date: Date
}
