//
//  ResponseTask.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/08/04.
//

import Foundation

struct ResponseTask: Decodable {

    let id: UUID
    let title: String
    let body: String?
    let dueDate: Int
    let state: Task.State

    var task: Task {
        let task = Task()
        task.id = id
        task.title = title
        task.body = body
        task.dueDate = Date(timeIntervalSince1970: TimeInterval(dueDate))
        task.taskState = state
        return task
    }
}
