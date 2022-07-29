//
//  History.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 2022/07/25.
//

import Foundation

struct History: Hashable {
    let title: String?
    let date: Date
    let from: TaskType?
    let to: TaskType?
    let changedType: WorkType
    let body: String?
    
    init(task: Task, changedType: WorkType, to: TaskType? = nil) {
        self.title = task.title
        self.date = Date.now
        self.from = task.taskType
        self.to = to
        self.changedType = changedType
        self.body = task.body
    }
}
