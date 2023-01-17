//
//  TaskListViewModel.swift
//  ProjectManager
//
//  Created by 서현웅 on 2023/01/13.
//

import Foundation

class TaskListViewModel {
    var reloadTodoTasks: () -> Void = {}
    
    var tasks: [Task] = [] {
        didSet {
            sortOutLastTasks()
        }
    }
    
    var todoTasks: [Task] = [] {
        didSet {
            reloadTodoTasks()
        }
    }
    var doingTasks: [Task] = []
    var doneTasks: [Task] = []
    
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
}
