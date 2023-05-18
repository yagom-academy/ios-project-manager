//
//  ToDoModel.swift
//  ProjectManager
//
//  Created by 무리 on 2023/05/17.
//

import Foundation

struct ToDoModel {
    var title: String
    var description: String
    var deadLine: Date
    var state: State
}

enum State {
    case Todo
    case Doing
    case Done
}
