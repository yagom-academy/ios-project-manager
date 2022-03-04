//
//  TaskListViewModel.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/02.
//

import Foundation

final class TaskListViewModel: TaskViewModel {
    var taskDidUpdated: (() -> Void)?
    var didSelectTask: ((Task) -> Void)?
    
    private let taskManager: TaskMangeable
    private(set) var tasks = [Task]()
    
    init(taskManager: TaskMangeable) {
        self.taskManager = taskManager
    }
    
    func didLoaded() {
        updateTasks()
    }
    
    private func updateTasks() {
        tasks = taskManager.fetchAll()
        taskDidUpdated?()
    }
    
    func create(with task: Task) {
        taskManager.create(with: task)
        updateTasks()
    }
    
    func update(with task: Task) {
        taskManager.update(with: task)
        updateTasks()
    }
    
    func delete(with task: Task) {
        taskManager.delete(with: task)
        updateTasks()
    }
    
    func changeState(of task: Task, to state: TaskState) {
        taskManager.changeState(of: task, to: state)
        updateTasks()
    }
    
    func fetch(at index: Int, with state: TaskState) throws -> Task {
        let filteredTasks = tasks.filter { $0.state == state }
        guard let fetchedTask = filteredTasks[safe: index] else {
            throw CollectionError.indexOutOfRange
        }
        
        return fetchedTask
    }
    
    func didSelectRow(at index: Int, with state: TaskState) {
        let filteredTasks = tasks.filter { $0.state == state }
        guard let selectedTask = filteredTasks[safe: index] else {
            return
        }
        
        didSelectTask?(selectedTask)
    }
    
    func count(of state: TaskState) -> Int {
        return tasks.filter { $0.state == state }.count
    }
}
