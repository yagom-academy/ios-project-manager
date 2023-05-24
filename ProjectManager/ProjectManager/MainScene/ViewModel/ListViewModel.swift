//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/19.
//

final class ListViewModel {
    
    var tasks: [Task] = []
    var taskState: TaskState
    
    init(taskState: TaskState) {
        self.taskState = taskState
    }
    
    func appendTask(_ task: Task) {
        tasks.append(task)
    }
}
