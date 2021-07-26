//
//  TaskEditViewModel.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/26.
//

import Foundation

struct TaskEditViewModel {
    var task: Task?
    var indexPath: IndexPath?
    var updated: ((IndexPath, Task) -> Void)?

    mutating func update(title: String, dueDate: Date, body: String) {
        guard let task = task,
              let indexPath = indexPath else { return }
        task.title = title
        task.dueDate = dueDate
        task.body = body
        updated?(indexPath, task)
    }
}
