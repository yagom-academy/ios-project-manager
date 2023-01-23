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
            sortOutTasks()
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
            doingTasks.append(lastTask)
        case .done:
            doneTasks.append(lastTask)
        }
    }
    
    private func deleteTaskWithSameId(statusTasks: [Task], indexPathRow: Int) {
        for index in tasks.startIndex...tasks.endIndex {
            if tasks[index].uuid == statusTasks[indexPathRow].uuid {
                tasks.remove(at: index)
                return
            }
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
    
    func moveToStatus(tasks: [Task], indexPathRow: Int, to status: Status) {
        let beforeTask = tasks[indexPathRow]
        let newTask = Task(title: beforeTask.title, description: beforeTask.description, date: beforeTask.date, status: status)
        deleteTaskWithSameId(statusTasks: tasks, indexPathRow: indexPathRow)
        create(task: newTask)
    }
    
}
