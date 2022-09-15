//
//  TaskDashboardViewModel.swift
//  ProjectManager
//
//  Created by minsson on 2022/09/15.
//

import Foundation

class TaskDashboardViewModel: ObservableObject {
    
    @Published var tasks: [Task] = []
    
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
