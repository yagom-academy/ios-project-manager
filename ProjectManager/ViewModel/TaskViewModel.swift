//
//  TaskViewModel.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/07.
//

import Foundation

class TaskViewModel: ObservableObject {
    var task: Task?
    var taskArray: [Task] = []
    @Published var title: String = ""
    @Published var date: Date = Date()
    @Published var body: String = ""
    
    func addTask() {
        task = Task(title: self.title, date: self.date, body: self.body)
        if let finalTask = task {
            taskArray.append(finalTask)
        }
    }
}
