//
//  TaskFormViewModel.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/22.
//

import Foundation

final class TaskFormViewModel {
    private let state: State = .todo
    private let taskManager = TaskManager.shared
    private var task: Task?
    
    func addTask(title: String, date: Date, body: String) {
        let task = Task(state: state, title: title, body: body, deadline: date)
        
        taskManager.create(task: task)
    }
}
