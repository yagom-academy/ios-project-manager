//
//  Task.swift
//  ProjectManager
//
//  Created by jin on 1/21/23.
//

import Foundation

struct Task {
    let title: String
    let description: String
    let date: Date
    var status: TaskStatus
}

enum TaskStatus: String {
    case todo = "TODO"
    case done = "DONE"
    case doing = "DOING"
}
