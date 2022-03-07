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
    
    func createTask(title: String, description: String, deadline: Date) {
        let newTask = Task(id: UUID(),
                           title: title,
                           description: description,
                           deadline: deadline,
                           state: .waiting)
        taskManager.create(with: newTask)
        updateTasks()
    }
    
    func updateRow(with task: Task) {
        taskManager.update(with: task)
        updateTasks()
    }
    
    func deleteRow(with task: Task) {
        taskManager.delete(with: task)
        updateTasks()
    }
    
    func move(task: Task, to state: TaskState) {
        taskManager.changeState(of: task, to: state)
        updateTasks()
    }
    
    func task(at index: Int, with state: TaskState, completion: (Task) -> Void) {
        guard let fetchedTask = taskManager.fetch(at: index, with: state) else {
            return 
        }
        
        completion(fetchedTask)
    }
    
    func didSelectRow(at index: Int, with state: TaskState) {
        guard let fetchedTask = taskManager.fetch(at: index, with: state) else {
            return
        }
        
        didSelectTask?(fetchedTask)
    }
    
    func count(of state: TaskState) -> Int {
        return tasks.filter { $0.state == state }.count
    }
}
