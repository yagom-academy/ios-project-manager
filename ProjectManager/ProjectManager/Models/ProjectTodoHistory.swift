//
//  ProjectTodoHistory.swift
//  ProjectManager
//
//  Created by junho lee on 2023/01/27.
//

import Foundation

struct ProjectTodoHistory {
    var id: UUID = UUID()
    var oldValue: ProjectTodo?
    var newValue: ProjectTodo?
    var action: Action
    var date: Date

    init(oldValue: ProjectTodo? = nil, newValue: ProjectTodo? = nil, action: Action, date: Date) {
        self.oldValue = oldValue
        self.newValue = newValue
        self.action = action
        self.date = date
    }
}

extension ProjectTodoHistory {
    enum Action {
        case add, move, remove
    }
}
