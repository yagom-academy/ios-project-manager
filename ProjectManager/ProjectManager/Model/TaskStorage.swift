//
//  TaskManager.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/04.
//

import Foundation

class TaskStorage {
    private var tasks: [Task]
    
    var todoTasks: [Task] {
        return tasks.filter { $0.status == .todo }
    }
    
    var doingTasks: [Task] {
        return tasks.filter { $0.status == .doing }
    }
    
    init() {
        tasks = []
    }
    
    var doneTasks: [Task] {
        return tasks.filter { $0.status == .done }
    }
    
    func insert(_ task: Task) {
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
    
    func delete(task: Task?) {
        guard let task = task else {
            return
        }
        tasks.removeAll { $0 == task }
    }
    
    func changeStatus( task: Task?, _ taskStatus: TaskStatus) {
        guard let task = task else {
            return
        }
        task.status = taskStatus
    }
}
