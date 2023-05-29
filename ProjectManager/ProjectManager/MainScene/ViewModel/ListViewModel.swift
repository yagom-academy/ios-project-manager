//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/19.
//

import Foundation

final class ListViewModel {
    
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
        vc?.viewModel.changeTaskState(by: task, state)
    }
    
    func postDeleteTask(by vc: MainViewController?, task: Task) {
        vc?.viewModel.deleteTask(task)
    }
}
