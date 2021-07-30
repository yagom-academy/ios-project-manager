//
//  ViewModel.swift
//  ProjectManager
//
//  Created by 최정민 on 2021/07/19.
//

import Foundation

final class TaskViewModel {
    private let networkManager = NetworkManager()
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
        taskList.insert(task.taskID, at: index)
        taskCache.setObject(task, forKey: task.taskID as NSString)
    }
    
    func deleteTaskFromTaskList(index: Int, taskID: String) {
        taskList.remove(at: index)
        taskCache.removeObject(forKey: taskID as NSString)
    }
    
    func updateTaskIntoTaskList(indexPath: IndexPath, task: Task) {
        taskList[indexPath.row] = task.taskID
        taskCache.setObject(task, forKey: task.taskID as NSString)
    }
    
    func getTask() {
        networkManager.get { taskList in
            
        }
    }
    
    func postTask() {
        networkManager.post() { Task in
            
        }
    }
    
    func patchTask() {
        networkManager.patch() {
        }
    }
    
    func deleteTask() {
        networkManager.delete() {
        }
    }
}
