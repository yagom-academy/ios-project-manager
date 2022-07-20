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
    
    func addTask(title: String, date: Date, body: String) {
        task = Task(title: title, date: date, body: body)
        if let finalTask = task {
            taskArray.append(finalTask)
        }
    }
}
