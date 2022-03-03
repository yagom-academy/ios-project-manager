//
//  TaskManager.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/04.
//

import Foundation

class TaskManager {
    func insert(taskType: TaskType, task: Task) {
        var store = taskType.store
        store.insert(Task(title: "test2", content: "test content2", limitDate: Date()), at: 0)
    }
    
    func update(task: Task?, title: String, content: String, date: Date) {
        guard let task = task else {
            return
        }
        task.title = title
        task.content = content
        task.limitDate = date
    }
    
    func delete(taskType: TaskType, task: Task) {
        var store = taskType.store
        store.removeAll { $0 == task }
    }
}
