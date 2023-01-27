//
//  TaskItemViewModel.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

final class TaskItemViewModel {
    let task: Task
    let title: String
    let description: String
    let date: Date
    let status: Task.Status

    init(task: Task) {
        self.task = task
        self.title = task.title
        self.description = task.description
        self.date = task.expireDate
        self.status = task.status
    }
}
