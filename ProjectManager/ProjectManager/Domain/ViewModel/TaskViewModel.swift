//
//  TaskViewModel.swift
//  ProjectManager
//
//  Created by 이예은 on 2022/09/22.
//

import Foundation

struct TaskViewModel: Equatable {
    let title: String
    let body: String
    let date: String
    let id: UUID
    let state: TaskState
    
    init(task: Task) {
        title = task.title
        body = task.body
        date = task.date.toString()
        id = task.id
        state = task.state
    }
    
    init(id: UUID, title: String, body: String, date: Date, state: TaskState) {
        self.id = id
        self.title = title
        self.body = body
        self.date = date.toString()
        self.state = state
    }
}
