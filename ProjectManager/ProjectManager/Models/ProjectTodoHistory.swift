//
//  ProjectTodoHistory.swift
//  ProjectManager
//
//  Created by junho lee on 2023/01/27.
//

import Foundation

struct ProjectTodoHistory {
    var id: UUID = UUID()
    var action: Action
    var oldValue: ProjectTodo?
    var newValue: ProjectTodo?
    var date: Date

    init(action: Action, oldValue: ProjectTodo? = nil, newValue: ProjectTodo? = nil, date: Date = Date()) {
        self.action = action
        self.oldValue = oldValue
        self.newValue = newValue
        self.date = date
    }
}

extension ProjectTodoHistory {
    enum Action {
        case add, move, remove
    }
}
