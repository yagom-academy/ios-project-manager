//
//  TaskMemoryManager.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/01.
//

import Foundation

struct TaskMemoryManager: TaskManager {
    
    private var tasks: [Task]
    
    var todoTasks: [Task] {
        tasks.filter { $0.status == .todo }
    }
    
    var doingTasks: [Task] {
        tasks.filter { $0.status == .doing }
    }
    
    var doneTasks: [Task] {
        tasks.filter { $0.status == .done }
    }
    
    init(tasks: [Task]) {
        self.tasks = tasks
    }
    
    mutating func create(_ task: Task) throws {
        tasks.append(task)
    }
    
    mutating func delete(_ task: Task) throws {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else {
            throw TaskMemoryManagerError.taskNotExist
        }
        tasks.remove(at: index)
    }
    
    mutating func update(_ oldTask: Task, to newTask: Task) throws {
        guard let index = tasks.firstIndex(where: { $0.id == oldTask.id }) else {
            throw TaskMemoryManagerError.taskNotExist
        }
        tasks[index].title = newTask.title
        tasks[index].description = newTask.description
        tasks[index].dueDate = newTask.dueDate
        tasks[index].status = newTask.status
    }
    
    enum TaskMemoryManagerError: Error {
        
        case taskNotExist
        
    }
    
}
