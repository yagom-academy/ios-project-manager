//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/19.
//

final class MainViewModel {
    private var tasks: [Task] = []
    
    func appendTask(_ task: Task) {
        tasks.append(task)
    }
    
    func filterTasks(by state: TaskState) -> [Task] {
        let filteredTasks = tasks.filter { task in
            return task.state == state
        }
        
        return filteredTasks
    }
}
