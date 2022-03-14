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
    var taskDidDeleted: ((Int, TaskState) -> Void)?
    var taskDidChanged: ((Int, TaskState) -> Void)?
    var taskDidMoved: ((Int, TaskState, TaskState) -> Void)?
    var tasksDidUpdated: (() -> Void)?
    var didSelectTask: ((Int, Task) -> Void)?
    
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
        taskDidChanged?(index, state)
    }
    
    func deleteRow(at index: Int, from state: TaskState) {
        taskManager.delete(at: index, from: state)
        updateTasks()
        taskDidDeleted?(index, state)
    }
    
    func move(at index: Int, from oldState: TaskState, to newState: TaskState) {
        taskManager.changeState(at: index, from: oldState, to: newState)
        updateTasks()
        taskDidMoved?(index, oldState, newState)
    }
    
    func task(at index: Int, from state: TaskState) -> TaskCell? {
        guard let fetchedTask = taskManager.fetch(at: index, from: state) else {
            presentErrorAlert?(CollectionError.indexOutOfRange)
            return nil
        }
        
        var deadline: NSAttributedString
        if [.waiting, .progress].contains(state) && fetchedTask.deadline < Date() {
            deadline = NSAttributedString(string: fetchedTask.deadline.dateString, attributes: TextAttribute.overDeadline)
        } else {
            deadline = NSAttributedString(string: fetchedTask.deadline.dateString, attributes: TextAttribute.underDeadline)
        }
        
        let taskCell = TaskCell(title: fetchedTask.title,
                                description: fetchedTask.description,
                                deadline: deadline)
        
        return taskCell
    }
    
    func didSelectRow(at index: Int, from state: TaskState) {
        guard let fetchedTask = taskManager.fetch(at: index, from: state) else {
            presentErrorAlert?(CollectionError.indexOutOfRange)
            return
        }
        
        didSelectTask?(index, fetchedTask)
    }
    
    func count(of state: TaskState) -> Int {
        return tasks.filter { $0.state == state }.count
    }
}

private extension Date {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.locale = .current
        return dateFormatter
    }()
    
    var dateString: String {
        return Self.dateFormatter.string(from: self)
    }
}
