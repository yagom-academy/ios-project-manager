//
//  TaskManager.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/02.
//

import Foundation

class TaskManager: TaskManageable {
    
    private var tasks = [Task]() {
        didSet {
            tasks.sort { $0.dueDate < $1.dueDate }
        }
    }
    var todoTasks: [Task] {
        return tasks.filter { $0.status == .todo }
    }
    var doingTasks: [Task] {
        return tasks.filter { $0.status == .doing }
    }
    var doneTasks: [Task] {
        return tasks.filter { $0.status == .done }
    }
    
    func createTask(title: String, body: String, dueDate: Date) {
        let newTask = Task(title: title, body: body, dueDate: dueDate)
        tasks.append(newTask)
    }
    
    func modifyTask(target: Task?, title: String, body: String, dueDate: Date) throws {
        guard let target = target else {
            throw TaskManagerError.taskIsNil
        }
        
        target.title = title
        target.body = body
        target.dueDate = dueDate
    }
    
    func changeTaskStatus(target: Task?, to status: TaskStatus) throws {
        guard let target = target else {
            throw TaskManagerError.taskIsNil
        }
        
        target.status = status
    }
    
    func deleteTask(target: Task) throws {
        guard let targetIndex = tasks.firstIndex(of: target) else {
            throw TaskManagerError.noTaskFound
        }
        
        tasks.remove(at: targetIndex)
    }
}
