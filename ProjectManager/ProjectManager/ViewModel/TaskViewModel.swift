//
//  TaskViewModel.swift
//  ProjectManager
//
//  Created by 서현웅 on 2023/01/13.
//

import Foundation

struct TaskViewModel {
    private let task: Task
    
    init(_ task: Task) {
        self.task = task
    }
}

extension TaskViewModel {
    var title: String? {
        return self.task.title
    }
    var description: String? {
        return self.task.description
    }
    var date: Date? {
        return self.task.date
    }
    var status: Status {
        return self.task.status
    }
}
