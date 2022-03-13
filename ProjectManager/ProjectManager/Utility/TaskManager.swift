//
//  TaskManager.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/02.
//

import Foundation

class TaskManager: ObservableObject, TaskManageable {
    
    @Published private var tasks = [Task]()
    
    var todoTasks: [Task] {
        return tasks.filter { $0.status == .todo }.sorted { $0.dueDate < $1.dueDate }
    }
    var doingTasks: [Task] {
        return tasks.filter { $0.status == .doing }.sorted { $0.dueDate < $1.dueDate }
    }
    var doneTasks: [Task] {
        return tasks.filter { $0.status == .done }.sorted { $0.dueDate < $1.dueDate }
    }
    
    init(tasks: [Task]) {
        self.tasks = tasks
    }
    
    func validateNewTask(title: String, body: String) -> Bool {
        return title.isEmpty == false && body.count <= 1000
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
    
    func deleteTask(target: Task?) throws {
        guard let target = target else {
            throw TaskManagerError.taskIsNil
        }
        
        guard let targetIndex = tasks.firstIndex(of: target) else {
            throw TaskManagerError.taskIsNil
        }
        
        tasks.remove(at: targetIndex)
    }
}
