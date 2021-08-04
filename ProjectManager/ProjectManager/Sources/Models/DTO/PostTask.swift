//
//  PostTask.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/08/04.
//

import Foundation

struct PostTask: Encodable {

    let id: UUID
    let title: String
    let body: String?
    let dueDate: Date
    let state: Task.State

    init(by task: Task) {
        id = task.id
        title = task.title
        body = task.body
        dueDate = task.dueDate
        state = task.taskState
    }
}
