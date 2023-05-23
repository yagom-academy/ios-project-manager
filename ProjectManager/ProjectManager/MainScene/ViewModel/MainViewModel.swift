//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/23.
//

import Foundation

extension Notification.Name {
    static var changedTasks = Notification.Name("changedTasks")
    static var deleteTask = Notification.Name("deleteTask")
}

class MainViewModel {
    
    private var tasks: [Task] = [] {
        didSet {
            NotificationCenter.default.post(name: .changedTasks,
                                            object: nil)
        }
    }
    
    init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(deleteTask(_:)),
                                               name: .deleteTask,
                                               object: nil)
    }
    
    @objc private func deleteTask(_ noti: Notification) {
        guard let task = noti.userInfo?["task"] as? Task,
              let targetIndex = tasks.firstIndex(of: task) else { return }
        
        tasks.remove(at: targetIndex)
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
