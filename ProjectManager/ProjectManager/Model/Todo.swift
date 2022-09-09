//
//  Todo.swift
//  ProjectManager
//
//  Created by Finnn on 2022/09/08.
//

import Foundation

struct Todo {
    var title: String
    var body: String
    var createdAt: Date
    var status: TodoStatus
    var isOutdated: Bool
}
