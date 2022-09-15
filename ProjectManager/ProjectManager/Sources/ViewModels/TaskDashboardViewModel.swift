//
//  TaskDashboardViewModel.swift
//  ProjectManager
//
//  Created by minsson on 2022/09/15.
//

import Foundation

class TaskDashboardViewModel: ObservableObject {
    
    @Published var tasks: [Task] = [
        Task(title: "Title 1", description: "Description 1", dueDate: Date.now, status: .todo),
        Task(title: "Title 2", description: "Description 2", dueDate: Date.now, status: .doing),
        Task(title: "Title 3", description: "Description 3", dueDate: Date.now, status: .done)
    ]
    
    var todo: [Task] {
        tasks.filter { $0.status == .todo }
    }
    
    var doing: [Task] {
        tasks.filter { $0.status == .doing }
    }
    
    var done: [Task] {
        tasks.filter { $0.status == .doing }
    }
}
