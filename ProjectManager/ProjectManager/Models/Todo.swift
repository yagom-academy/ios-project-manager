//
//  Todo.swift
//  ProjectManager
//
//  Created by YongHoon JJo on 2021/11/02.
//

import Foundation

struct Todo: Identifiable, Hashable {
    enum TodoStatus {
        case todo
        case doing
        case done
    }
    
    let id = UUID()
    var title: String
    var description: String
    var dueDate: Date
    var status: TodoStatus
}
