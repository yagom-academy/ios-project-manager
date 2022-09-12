//
//  TaskModel.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/12.
//

import Foundation

struct TaskModel {
    var taskTitle: String = ""
    var taskDescription: String = ""
    var taskDeadline: String = ""
    var taskState: String = TaskState.none
    var id: UUID?
}

enum TaskState {
    static let todo = "TODO"
    static let doing = "DOING"
    static let done = "DONE"
    static let none = "NONE"
}
