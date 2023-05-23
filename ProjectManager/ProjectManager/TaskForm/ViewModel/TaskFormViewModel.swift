//
//  TaskFormViewModel.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/22.
//

import Foundation
import Combine

final class TaskFormViewModel {
    private let taskManager = TaskManager.shared
    private var task: Task?
    
    var title: String {
        return task?.title ?? ""
    }
    
    var body: String {
        return task?.body ?? ""
    }
    
    var deadline: Date {
        return task?.deadline ?? Date()
    }
    
    var leftBarButtonTitle: String {
        return task != nil ? "Edit" : "Cancel"
    }
    
    var rightBarButtonTitle: String {
        return "Done"
    }
    
    var navigationTitle: String? {
        return task != nil ? task?.state.description : State.todo.description
    }
    
    var isEditable: Bool {
        return task == nil
    }
    
    init(task: Task? = nil) {
        self.task = task
    }
    
    func doneAction(title: String, date: Date, body: String) {
        if task != nil {
            updateTask(title: title, date: date, body: body)
            
            return
        }
        
        addTask(title: title, date: date, body: body)
    }
    
    private func addTask(title: String, date: Date, body: String) {
        let task = Task(state: .todo, title: title, body: body, deadline: date)
        
        taskManager.create(task: task)
    }
    
    private func updateTask(title: String, date: Date, body: String) {
        task?.title = title
        task?.deadline = date
        task?.body = body
        
        guard let task else { return }
        
        taskManager.update(task: task)
    }
}
