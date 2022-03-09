//
//  TaskListViewModel.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/02.
//

import Foundation

final class TaskListViewModel: TaskViewModel {
    // MARK: - Output
    var presentErrorAlert: ((Error) -> Void)?
    var taskDidCreated: (() -> Void)?
//    var taskDidFetched: ((Task) -> Void)?
    var taskDidDeleted: ((Int, TaskState) -> Void)?
    var taskDidChanged: ((Int) -> Void)?
    var taskDidMoved: ((Int, TaskState) -> Void)?
    var tasksDidUpdated: (() -> Void)?
    var didSelectTask: ((Task) -> Void)?
    
    private let taskManager: TaskMangeable
    private(set) var tasks = [Task]()
    
    init(taskManager: TaskMangeable) {
        self.taskManager = taskManager
    }
    
    func didLoaded() {
        updateTasks()
        tasksDidUpdated?()
    }
    
    private func updateTasks() {
        tasks = taskManager.fetchAll()
    }
    
    func createTask(title: String, description: String, deadline: Date) {
        taskManager.create(title: title, description: description, deadline: deadline)
        updateTasks()
        taskDidCreated?()        
    }
    
    func updateRow(at index: Int, title: String, description: String, deadline: Date, from state: TaskState) {
        taskManager.update(at: index, title: title, description: description, deadline: deadline, from: state)
        taskDidChanged?(index)
    }
    
    func deleteRow(at index: Int, from state: TaskState) {
        taskManager.delete(at: index, from: state)
        updateTasks()
        taskDidDeleted?(index, state)
    }
    
    func move(at index: Int, to state: TaskState) {
        taskManager.changeState(at: index, to: state)
        taskDidMoved?(index, state)
    }
    
    func task(at index: Int, from state: TaskState) -> Task? {
        guard let fetchedTask = taskManager.fetch(at: index, from: state) else {
            presentErrorAlert?(CollectionError.indexOutOfRange)
            return nil
        }
        
        return fetchedTask
    }
    
    func didSelectRow(at index: Int, from state: TaskState) {
        guard let fetchedTask = taskManager.fetch(at: index, from: state) else {
            presentErrorAlert?(CollectionError.indexOutOfRange)
            return
        }
        
        didSelectTask?(fetchedTask)
    }
    
    func count(of state: TaskState) -> Int {
        return tasks.filter { $0.state == state }.count
    }
}
