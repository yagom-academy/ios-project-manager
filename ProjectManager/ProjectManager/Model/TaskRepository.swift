//
//  TaskManager.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/04.
//

import Foundation

enum TaskRepositoryError: Error {
    case taskUpdateFail
    case taskDeleteFail
    case taskChangeStatusFail
}

class TaskRepository {
    var tasks: [TaskEntity]
    
    init() {
        tasks = []
    }
    
    func insert(_ task: TaskEntity) {
        tasks.insert(task, at: 0)
    }
    
    func update(task: TaskEntity?, title: String, content: String, date: Date) throws {
        guard let task = task else {
            throw TaskRepositoryError.taskUpdateFail
        }
        task.title = title
        task.content = content
        task.limitDate = date
    }
    
    func delete(task: TaskEntity?) throws {
        guard let task = task else {
            throw TaskRepositoryError.taskDeleteFail
        }
        tasks.removeAll { $0 == task }
    }
    
    func changeStatus(task: TaskEntity?, _ taskStatus: TaskStatus) throws {
        guard let task = task else {
            throw TaskRepositoryError.taskChangeStatusFail
        }
        task.status = taskStatus
    }
}
