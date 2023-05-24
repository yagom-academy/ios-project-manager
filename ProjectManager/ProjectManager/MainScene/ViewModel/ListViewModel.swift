//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/19.
//

import Foundation

final class ListViewModel {
    
    var tasks: [Task] = []
    var taskState: TaskState
    
    init(taskState: TaskState) {
        self.taskState = taskState
    }
    
    func postChangedTaskState(by task: Task, _ state: TaskState) {
        NotificationCenter.default.post(name: .changedTaskState, object: nil, userInfo: ["task": task, "state": state])
    }
}
