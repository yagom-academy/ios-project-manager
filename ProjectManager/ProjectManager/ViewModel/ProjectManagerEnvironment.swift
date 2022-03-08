//
//  ProjectManagerEnvironment.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/08.
//

import Foundation

struct ProjectManagerEnvironment {
    var taskRepository: TaskRepository
    
    init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
    }
    
    func getTaskList() -> [Task] {
        return taskRepository.tasks.map { $0.toViewModel() }
    }
}
