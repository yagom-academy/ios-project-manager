//
//  TaskCellViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/17.
//

import Foundation

final class TaskCellViewModel {
    private let task: Task
    private let dateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd"

        return formatter
    }()
    
    init(task: Task) {
        self.task = task
    }
    
    var title: String { return task.title }
    
    var body: String { return task.body }
    
    var date: String { return dateFormatter.string(from: task.date) }
    
    var workState: WorkState { return task.workState }
}
