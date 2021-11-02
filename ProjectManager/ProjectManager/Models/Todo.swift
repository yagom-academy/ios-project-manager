//
//  Todo.swift
//  ProjectManager
//
//  Created by YongHoon JJo on 2021/11/02.
//

import Foundation

enum TodoStatus {
    case todo
    case doing
    case done
    
    var title: String {
        switch self {
        case .todo: return "TODO"
        case .doing: return "DOING"
        case .done: return "DONE"
        }
    }
}

struct Todo {
    var title: String
    var description: String
    var dueDate: Date
    var status: TodoStatus
}
