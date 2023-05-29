//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/23.
//

import Foundation

class MainViewModel {
    
    private var tasks: [Task] = [] {
        didSet {
            NotificationCenter.default.post(name: .changedTasks,
                                            object: nil)
        }
    }
    
    func deleteTask(_ task: Task) {
        guard let targetIndex = tasks.firstIndex(of: task) else { return }
        
        tasks.remove(at: targetIndex)
    }
    
    func changeTaskState(by task: Task, _ state: TaskState) {
        guard let targetIndex = tasks.firstIndex(of: task) else { return }
        
        tasks[targetIndex].state = state
    }
    
    func replaceTask(_ task: Task) {
        let firstIndex = tasks.firstIndex { targetTask in
            return targetTask.id == task.id
        }
        
        guard let targetIndex = firstIndex else { return }
        
        tasks[targetIndex] = task
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
