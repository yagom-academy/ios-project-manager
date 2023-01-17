//
//  TaskListViewModel.swift
//  ProjectManager
//
//  Created by 서현웅 on 2023/01/13.
//

import Foundation

class TaskListViewModel {
    var tasks: [Task] = []
}

extension TaskListViewModel {
    func setSampleData(_ sampleData: [Task]) {
        tasks = sampleData
    }
    
}
