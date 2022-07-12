//
//  TaskViewModel.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/07.
//

import Foundation

class TaskViewModel: ObservableObject {
    var task: Task?
    @Published var title: String = ""
    @Published var dueDate: Date = Date()
    @Published var body: String = ""
    
    func addTask() {
        task = Task(title: self.title, date: self.dueDate, body: self.body, type: .todo)
    }
}
