//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/23.
//

import Foundation

class MainViewModel {
    
    private let dbManager = DBManager()
    private let networkMonitor = NetworkMonitor()
    private var tasks: [Task] = [] {
        didSet {
            postChangedTasksNoti()
        }
    }
    
    init() {
        networkMonitor.checkNetworkState { [weak self] isConnect in
            self?.dbManager.changeDatabase(isConnect: isConnect, syncedObjects: self?.tasks)
            self?.fetchTasks()
        }
    }
    
    private func fetchTasks() {
        dbManager.fetch { [weak self] result in
            switch result {
            case .success(let tasks):
                guard let tasks = tasks as? [Task] else { return }
                self?.tasks = tasks
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func deleteTask(_ task: Task) {
        guard let targetIndex = tasks.firstIndex(of: task) else { return }
        
        tasks.remove(at: targetIndex)
        
        dbManager.delete(object: task)
    }
    
    func changeTaskState(by task: Task, _ state: TaskState) {
        guard let targetIndex = tasks.firstIndex(of: task) else { return }
        
        tasks[targetIndex].state = state
        
        dbManager.update(object: tasks[targetIndex])
    }
    
    func replaceTask(_ task: Task) {
        let firstIndex = tasks.firstIndex { targetTask in
            return targetTask.id == task.id
        }
        
        guard let targetIndex = firstIndex else { return }
        
        tasks[targetIndex] = task
        
        dbManager.update(object: task)
    }
    
    func appendTask(_ task: Task) {
        tasks.append(task)
        
        dbManager.create(object: task)
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
