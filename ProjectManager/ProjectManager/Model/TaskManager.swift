//
//  TaskManager.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/04.
//

import Foundation

class TaskManager {
    private var tasks: [Task] = []
    
    var todoTasks: [Task] {
        return tasks.filter { $0.status == .todo }
    }
    var doingTasks: [Task] {
        return tasks.filter { $0.status == .doing }
    }
    var doneTasks: [Task] {
        return tasks.filter { $0.status == .done }
    }
    
    func insert(title: String, content: String, date: Date) {
        let task = Task(
            title: title,
            content: content,
            limitDate: date,
            status: .todo,
            statusModifiedDate: Date().timeIntervalSince1970
        )
        tasks.insert(task, at: 0)
    }
    
    func update(task: Task?, title: String, content: String, date: Date) {
        guard let task = task else {
            return
        }
        task.title = title
        task.content = content
        task.limitDate = date
    }
    
    func delete(task: Task) {
        tasks.removeAll { $0 == task }
    }
    
    func changeStatus( task: Task, _ taskStatus: TaskStatus) {
        task.status = taskStatus
    }
}
