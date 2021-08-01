//
//  ViewModel.swift
//  ProjectManager
//
//  Created by 최정민 on 2021/07/19.
//

import Foundation

final class TaskViewModel {
    private let service = Service()
    private let taskCache = NSCache<NSString, Task>()
    var updateTaskCollectionView : () -> Void = {}
    private var taskList: [String] = [] {

        didSet {
            updateTaskCollectionView()
        }
    }
    
    init() {
        taskCache.evictsObjectsWithDiscardedContent = false
    }
    
    func referTask(at: IndexPath) -> Task? {
        if taskList.count > at.row {
            return taskCache.object(forKey: taskList[at.row] as NSString)
        }
        return nil
    }
    
    func taskListCount() -> Int {
        return taskList.count
    }
    
    func insertTaskIntoTaskList(index: Int, task: Task) {
        taskList.insert(task.id, at: index)
        taskCache.setObject(task, forKey: task.id as NSString)
    }
    
    func deleteTaskFromTaskList(index: Int, taskID: String) {
        taskList.remove(at: index)
        taskCache.removeObject(forKey: taskID as NSString)
    }
    
    func updateTaskIntoTaskList(indexPath: IndexPath, task: Task) {
        taskList[indexPath.row] = task.id
        taskCache.setObject(task, forKey: task.id as NSString)
    }
    
    func getTask(status: State) {
        service.getTask(status: status) { [weak self] tasks in
             // TODO: - Task에 ID만 따로 배열로 만들어야함
            let taskIds = tasks.map { $0.id }
            self?.taskList.append(contentsOf: taskIds)
            for task in tasks {
                self?.taskCache.setObject(task, forKey: task.id as NSString)
            }
            
        }
    }
    
    func postTask(task: Task) {
        service.postTask(task: task) { Task in
            
        }
    }
    
    func patchTask(task: Task) {
        service.patchTask(task: task) {
        }
    }
    
    func deleteTask(id: String) {
        service.deleteTask(id: id) {
        }
    }
}
