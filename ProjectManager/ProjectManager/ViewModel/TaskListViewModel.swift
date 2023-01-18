//
//  TaskListViewModel.swift
//  ProjectManager
//
//  Created by 서현웅 on 2023/01/13.
//

import Foundation

class TaskListViewModel {
    var reloadTodoTasks: ([Task]) -> Void = { _ in }
    var reloadDoingTasks: ([Task]) -> Void = { _ in }
    var reloadDoneTasks: ([Task]) -> Void = { _ in }
    
    var tasks: [Task] = [] {
        didSet {
            sortOutLastTasks()
        }
    }
    
    var todoTasks: [Task] = [] {
        didSet {
            reloadTodoTasks(todoTasks)
        }
    }
    var doingTasks: [Task] = [] {
        didSet {
            reloadDoingTasks(doingTasks)
        }
    }
    var doneTasks: [Task] = [] {
        didSet {
            reloadDoneTasks(doneTasks)
        }
    }
    
    let sampleData = SampleDummyData()
    
    init() {
        self.setSampleData(sampleData.sampleDummy)
        self.sortOutTasks()
    }
    
}

extension TaskListViewModel {
    private func setSampleData(_ sampleData: [Task]) {
        tasks = sampleData
    }
    
    private func sortOutTasks() {
        todoTasks = tasks.filter { ($0).status == .todo }
        doingTasks = tasks.filter { ($0).status == .doing }
        doneTasks = tasks.filter { ($0).status == .done }
    }
    
    private func sortOutLastTasks() {
        guard let lastTask = tasks.last else { return }
        
        switch lastTask.status {
        case .todo:
            todoTasks.append(lastTask)
        case .doing:
            doneTasks.append(lastTask)
        case .done:
            doneTasks.append(lastTask)
        }
    }
}

extension TaskListViewModel {
    func create(task: Task) {
        tasks.append(task)
    }
    
    func update(status: Status, newTask: Task, indexPathRow: Int) {
        switch status {
        case .todo:
            todoTasks[indexPathRow] = newTask
        case .doing:
            doingTasks[indexPathRow] = newTask
        case .done:
            doneTasks[indexPathRow] = newTask
        }
        
    }
}
