//
//  History.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/22.
//

import Foundation

struct History: Equatable {
    static func == (lhs: History, rhs: History) -> Bool {
        return lhs.action == rhs.action &&
        lhs.identifier == rhs.identifier &&
        lhs.description == rhs.description &&
        lhs.status == rhs.status &&
        lhs.date == rhs.date &&
        lhs.title == rhs.title
    }

    let action: HistoryAction
    let identifier: UUID
    let title: String
    let description: String
    let status: HistoryStatus
    let date: Date

    func lastTodo() -> Todo {
        return Todo(
            todoListItemStatus: self.status.lastStatus,
            identifier: self.identifier,
            title: self.title,
            description: self.description,
            date: self.date
        )
    }

    func currentTodo() -> Todo {
        return Todo(
            todoListItemStatus: self.status.currentStatus,
            identifier: self.identifier,
            title: self.title,
            description: self.description,
            date: self.date
        )
    }
}
