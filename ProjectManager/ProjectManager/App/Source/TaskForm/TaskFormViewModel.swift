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
    private var task: MyTask?
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var isEditable: Bool
    @Published var isDone = false
    @Published var title: String = ""
    @Published var body: String = ""
    
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
        return task != nil ? task?.state.description : TaskState.todo.description
    }
    
    init(task: MyTask? = nil) {
        self.task = task
        isEditable = (task == nil)
        
        title = task?.title ?? ""
        body = task?.body ?? ""
        
        assignToIsDone()
    }

    func cancelOrEditAction(action: (() -> Void)?) {
        if task == nil {
            action?()
            
            return
        }
        
        isEditable = true
    }
    
    func doneAction(title: String, date: Date, body: String) {
        if task != nil {
            updateTask(title: title, date: date, body: body)
            
            return
        }
        
        if title != "" && body != "" {
            addTask(title: title, date: date, body: body)
        }
    }
    
    private func assignToIsDone() {
        Publishers
            .CombineLatest($title, $body)
            .map { (title, body) in
                !title.isEmpty && !body.isEmpty
            }
            .assign(to: \.isDone, on: self)
            .store(in: &subscriptions)
    }
    
    private func addTask(title: String, date: Date, body: String) {
        let task = MyTask(state: .todo, title: title, body: body, deadline: date)
        
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
