//
//  TaskManager.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/02.
//

import Foundation

final class TaskManager: ObservableObject, TaskManageable {
    
    @Published private var tasks = [Task]()
    
    func fetchTasks(in status: TaskStatus) -> [Task] {
        return tasks.filter { $0.status == status }.sorted { $0.dueDate < $1.dueDate }
    }
    
    func validateTask(title: String, body: String) -> Bool {
        return title.isEmpty == false && body.count <= 1000
    }
    
    func createTask(title: String, body: String, dueDate: Date) {
        let newTask = Task(title: title, body: body, dueDate: dueDate)
        tasks.append(newTask)
    }
    
    func editTask(target: Task?, title: String, body: String, dueDate: Date) throws {
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
    
    func deleteTask(indexSet: IndexSet, in status: TaskStatus) throws {
        guard let convertedIndex = indexSet.first else {
            throw TaskManagerError.taskIsNil
        }
        
        let target = fetchTasks(in: status)[convertedIndex]
        
        guard let targetIndex = tasks.firstIndex(of: target) else {
            throw TaskManagerError.taskIsNil
        }
        
        tasks.remove(at: targetIndex)
    }
}
