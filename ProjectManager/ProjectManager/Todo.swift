//
//  Todo.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/10/28.
//

import Foundation

struct Todo {
    enum Completion {
        case todo
        case doing
        case done
    }
    
    var title: String
    var detail: String
    var endDate: Date
    var completionState: Completion
}
