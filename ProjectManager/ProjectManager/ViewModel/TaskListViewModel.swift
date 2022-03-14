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
    var reloadTableView: (() -> Void)?
    var deleteRows: ((Int, TaskState) -> Void)?
    var reloadRows: ((Int, TaskState) -> Void)?
    var moveRows: ((Int, TaskState, TaskState) -> Void)?
    var reloadTableViews: (() -> Void)?
    var didSelectRows: ((Int, Task) -> Void)?
    var taskCount: (([(count: Int, state: TaskState)]) -> Void)?
    
    private let taskManager: TaskMangeable
    private(set) var tasks = [Task]()
    
    init(taskManager: TaskMangeable) {
        self.taskManager = taskManager
    }
    
    func onViewWillAppear() {
        updateTasks()
        reloadTableViews?()
    }
    
    private func updateTasks() {
        tasks = taskManager.fetchAll()
    }
    
    func createTask(title: String, description: String, deadline: Date) {
        taskManager.create(title: title, description: description, deadline: deadline)
        updateTasks()
        reloadTableView?()
        taskCount?([(count(of: .waiting), .waiting)])
    }
    
    func updateTask(at index: Int, title: String, description: String, deadline: Date, from state: TaskState) {
        taskManager.update(at: index, title: title, description: description, deadline: deadline, from: state)
        reloadRows?(index, state)
    }
    
    func deleteTask(at index: Int, from state: TaskState) {
        taskManager.delete(at: index, from: state)
        updateTasks()
        deleteRows?(index, state)
        taskCount?([(count(of: state), state)])
    }
    
    func moveTask(at index: Int, from oldState: TaskState, to newState: TaskState) {
        taskManager.changeState(at: index, from: oldState, to: newState)
        updateTasks()
        moveRows?(index, oldState, newState)
        taskCount?([(count(of: oldState), oldState), (count(of: newState), newState)])
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
    
    func selectTask(at index: Int, from state: TaskState) {
        guard let fetchedTask = taskManager.fetch(at: index, from: state) else {
            presentErrorAlert?(CollectionError.indexOutOfRange)
            return
        }
        
        didSelectRows?(index, fetchedTask)
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
