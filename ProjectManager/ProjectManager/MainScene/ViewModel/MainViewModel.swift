//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/23.
//

import Foundation

class MainViewModel {
    
    private let dbManager = LocalDBManager()
    private let networkManager = NetworkMonitor()
    private var tasks: [Task] = [] {
        didSet {
            postChangedTasksNoti()
        }
    }
    
    init() {
        dbManager?.fetchTasks({ [weak self] result in
            switch result {
            case .success(let tasks):
                self?.tasks = tasks
            case .failure(let error):
                print(error)
            }
        })
        
        networkManager.checkNetworkState()
    }
    
    func deleteTask(_ task: Task) {
        guard let targetIndex = tasks.firstIndex(of: task) else { return }
        
        tasks.remove(at: targetIndex)
        
        dbManager?.deleteTask(task)
    }
    
    func changeTaskState(by task: Task, _ state: TaskState) {
        guard let targetIndex = tasks.firstIndex(of: task) else { return }
        
        tasks[targetIndex].state = state
        
        dbManager?.updateTask(tasks[targetIndex])
    }
    
    func replaceTask(_ task: Task) {
        let firstIndex = tasks.firstIndex { targetTask in
            return targetTask.id == task.id
        }
        
        guard let targetIndex = firstIndex else { return }
        
        tasks[targetIndex] = task
        
        dbManager?.updateTask(task)
    }
    
    func appendTask(_ task: Task) {
        tasks.append(task)
        
        dbManager?.createTask(task)
    }
    
    func filterTasks(by state: TaskState) -> [Task] {
        return tasks.filter { task in
            return task.state == state
        }
    }
    
    private func postChangedTasksNoti() {
        NotificationCenter.default.post(name: .changedTasks,
                                        object: nil)
    }
}
