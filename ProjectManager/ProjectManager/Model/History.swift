//
//  History.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/22.
//

import Foundation

struct History: Equatable {
    let action: HistoryAction
    let nextTodo: Todo
    let previousTodo: Todo?
    
    var identifier: UUID {
        return nextTodo.identifier
    }
    
    var title: String {
        return "'\(nextTodo.title)'"
    }
    
    var status: String {
        switch action {
        case .moved:
            return "from \(previousTodo?.todoListItemStatus.displayName ?? "") to \(nextTodo.todoListItemStatus.displayName)"
        case .added:
            return "from \(nextTodo.todoListItemStatus.displayName)"
        case .edited:
            return "from \(nextTodo.todoListItemStatus.displayName)"
        case .removed:
            return "from \(nextTodo.todoListItemStatus.displayName)"
        }
    }
    
    var date: String {
        return nextTodo.date.dateString()
    }
}
