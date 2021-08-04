//
//  PatchTask.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/08/04.
//

import Foundation

struct PatchTask: Encodable {

    private let id: UUID
    private let title: String?
    private let body: String?
    private let dueDate: Int?
    private let state: Task.State?

    init(by task: Task) {
        id = task.id
        title = task.title
        body = task.body
        dueDate = Int(task.dueDate.timeIntervalSince1970)
        state = task.taskState
    }
}
