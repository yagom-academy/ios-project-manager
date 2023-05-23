//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/23.
//

import Foundation

class MainViewModel {
    
    private var tasks: [Task] = []
    
    init() {
    }
    
    func replaceTask(_ task: Task) {
        guard let index = tasks.firstIndex(where: { target in
            return target.id == task.id
        }) else { return }
        
        tasks[index] = task
    }
    
    func appendTask(_ task: Task) {
        tasks.append(task)
    }
    
    func filterTasks(by state: TaskState) -> [Task] {
        return tasks.filter { task in
            return task.state == state
        }
    }
}
