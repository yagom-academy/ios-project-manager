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
    
    init() {
        tasks = enviroment.getTaskList()
    }
    
    func createTask() {
        
    }
}
