//
//  ViewModel.swift
//  ProjectManager
//
//  Created by 최정민 on 2021/07/19.
//

import Foundation

final class TaskViewModel {
    private let service = Service()
    var updateTaskCollectionView : () -> Void = {}

    private var taskList: [Task] = [] {
        didSet {
            updateTaskCollectionView()
        }
    }
    
    func initTaskList(taskList: [String]) {
        
    }
    
    func referTask(at: IndexPath) -> Task? {
        if taskList.count > at.row {
            return taskList[at.row]
        }
        return nil
    }
    
    func taskListCount() -> Int {
        return taskList.count
    }
    
    func insertTaskIntoTaskList(index: Int, task: Task) {
        taskList.insert(task, at: index)
    }
    
    func deleteTaskFromTaskList(index: Int, taskID: String) {
        taskList.remove(at: index)
    }
    
    func updateTaskIntoTaskList(indexPath: IndexPath, task: Task) {
        taskList[indexPath.row] = task
    }
    
    func getTask(status: State) {
        service.getTask(status: status) { [weak self] tasks in
            self?.taskList.append(contentsOf: tasks)
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
