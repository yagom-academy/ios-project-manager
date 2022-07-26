//
//  SomeViewModel.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/12.
//

class TaskManagementService {
    var tasks: [Task] = []
    
    // CREATE
    func addTask(_ task: Task) {
        tasks.append(task)
    }
    
    // READ
    func readTasks() -> [Task] {
        return tasks
    }
    
    // UPDATE
    func editTask(task: Task) {
        guard let item = tasks.filter ({ $0 == task }).first else {
            return
        }
        
        guard let index = tasks.firstIndex(of: item) else {
            return
        }
        
        tasks[index].title = tasks[index].title
        tasks[index].body = tasks[index].body
        tasks[index].date = tasks[index].date
    }
    
    // DELETE
    
    // MOVE
    func moveTask(_ task: Task, to: TaskType) {
        guard let item = tasks.filter({ $0 == task }).first else {
            return
        }
        
        guard let index = tasks.firstIndex(of: item) else {
            return
        }
        
        var newItem = item
        newItem.type = to
        tasks.remove(at: index)
        tasks.append(newItem)
    }
}
