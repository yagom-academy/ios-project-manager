//
//  TaskCellViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/17.
//

import Foundation
import Combine

final class TaskCellViewModel {
    @Published var title: String
    @Published var body: String
    @Published var date: String
    
    init(task: Task, dateFormatter: DateFormatter) {
        title = task.title
        body = task.body
        date = dateFormatter.string(from: task.date)
    }
}
