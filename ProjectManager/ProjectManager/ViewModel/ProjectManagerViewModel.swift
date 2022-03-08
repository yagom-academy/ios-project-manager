//
//  ProjectManagerViewModel.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/07.
//

import Foundation

class ProjectManagerViewModel: ObservableObject {
    let enviroment = ProjectManagerEnvironment(taskRepository: TaskRepository())
    
    @Published var tasks: [Task]
    
    var todoTasks: [Task] {
        return tasks.filter { $0.status == .todo }
    }
    
    var doingTasks: [Task] {
        return tasks.filter { $0.status == .doing }
    }
    
    var doneTasks: [Task] {
        return tasks.filter { $0.status == .done }
    }
    
    init() {
        tasks = enviroment.getTaskList()
    }
    
    func createTask() {
        
    }
}
