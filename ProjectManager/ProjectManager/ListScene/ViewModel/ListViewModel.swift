//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/19.
//

import Foundation

final class ListViewModel {
    
    var isNetworkConnecting = true
    var tasks: [Task] = [] {
        didSet {
            NotificationCenter.default.post(name: .updatedTask, object: nil)
        }
    }
    var taskState: TaskState
    
    init(taskState: TaskState) {
        self.taskState = taskState
    }
    
    func postChangedTaskState(by vc: MainViewController?, task: Task, state: TaskState) {
        if isNetworkConnecting {
            vc?.viewModel.changeTaskState(by: task, state)
        }
    }
    
    func postDeleteTask(by vc: MainViewController?, task: Task) {
        if isNetworkConnecting {
            vc?.viewModel.deleteTask(task)
        }
    }
}
