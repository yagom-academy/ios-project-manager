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
}

extension TaskListViewModel {
    func create(task: Task) {
        tasks.append(task)
    }
    
    func update(task: Task, tasks: [Task], indexPathRow: Int) {
        delete(tasks: tasks, indexPathRow: indexPathRow)
        create(task: task)
    }
    
    
    func moveToStatus(tasks: [Task], indexPathRow: Int, to status: Status) {
        let beforeTask = tasks[indexPathRow]
        let newTask = Task(title: beforeTask.title,
                           description: beforeTask.description,
                           date: beforeTask.date, status: status)
        delete(tasks: tasks, indexPathRow: indexPathRow)
        create(task: newTask)
    }
    
    func delete(tasks: [Task], indexPathRow: Int) {
        for index in self.tasks.startIndex..<self.tasks.endIndex {
            if self.tasks[index].uuid == tasks[indexPathRow].uuid {
                self.tasks.remove(at: index)
                return
            }
        }
    }
}
