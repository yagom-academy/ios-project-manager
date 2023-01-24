//
//  ProjectTodo.swift
//  ProjectManager
//
//  Created by junho lee on 2023/01/13.
//

import Foundation

struct ProjectTodo {
    let id: UUID
    var state: ProjectState
    var title: String
    var description: String
    var dueDate: Date

    init(id: UUID = UUID(), state: ProjectState = .todo, title: String, description: String, dueDate: Date) {
        self.id = id
        self.state = state
        self.title = title
        self.description = description
        self.dueDate = dueDate
    }
}
