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
    
    init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(deleteTask),
                                               name: .deleteTask,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeTaskState),
                                               name: .changedTaskState,
                                               object: nil)
    }
    
    @objc private func deleteTask(_ noti: Notification) {
        guard let task = noti.userInfo?["task"] as? Task,
              let targetIndex = tasks.firstIndex(of: task) else { return }
        
        tasks.remove(at: targetIndex)
    }
    
    @objc private func changeTaskState(_ noti: Notification) {
        guard let task = noti.userInfo?["task"] as? Task,
              let state = noti.userInfo?["state"] as? TaskState,
              let targetIndex = tasks.firstIndex(of: task) else { return }
        
        tasks[targetIndex].state = state
    }
    
    func replaceTask(_ task: Task) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else {
            return
        }
        
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
