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
    var presentTaskManageView: ((TaskManageViewModel) -> Void)?
    var taskCount: (([(count: Int, state: TaskState)]) -> Void)?
    
    private let taskListUseCase: TaskListUseCase
    private(set) var tasks = [Task]()
    
    init(taskListUseCase: TaskListUseCase) {
        self.taskListUseCase = taskListUseCase
    }
    
    func onViewWillAppear() {
        updateTasks()
        reloadTableViews?()
    }
    
    private func updateTasks() {
        tasks = taskListUseCase.fetchAll()
    }
    
    func createTask(with task: Task) {
        taskListUseCase.create(with: task)
        updateTasks()
        reloadTableView?()
        taskCount?([(count(of: .waiting), .waiting)])
    }
    
    func updateTask(at index: Int, task: Task) {
        taskListUseCase.update(at: index, with: task)
        reloadRows?(index, task.state)
    }
    
    func deleteTask(at index: Int, from state: TaskState) {
        taskListUseCase.delete(at: index, from: state)
        updateTasks()
        deleteRows?(index, state)
        taskCount?([(count(of: state), state)])
    }
    
    func moveTask(at index: Int, from oldState: TaskState, to newState: TaskState) {
        taskListUseCase.changeState(at: index, from: oldState, to: newState)
        updateTasks()
        moveRows?(index, oldState, newState)
        taskCount?([(count(of: oldState), oldState), (count(of: newState), newState)])
    }
    
    func task(at index: Int, from state: TaskState) -> TaskCellViewModel? {
        guard let fetchedTask = taskListUseCase.fetch(at: index, from: state) else {
            presentErrorAlert?(CollectionError.indexOutOfRange)
            return nil
        }
        
        let taskCellViewModel = TaskCellViewModel(title: fetchedTask.title,
                                                  description: fetchedTask.description,
                                                  state: state,
                                                  deadline: fetchedTask.deadline)
        
        return taskCellViewModel
    }
    
    func addTask() {
        let taskManageUseCase = DefaultTaskManageUseCase()
        let taskManageViewModel = TaskManageViewModel(manageType: .add, taskManageUseCase: taskManageUseCase)
        presentTaskManageView?(taskManageViewModel)
    }
    
    func selectTask(at index: Int, from state: TaskState) {
        guard let fetchedTask = taskListUseCase.fetch(at: index, from: state) else {
            presentErrorAlert?(CollectionError.indexOutOfRange)
            return
        }
        
        let taskManageUseCase = DefaultTaskManageUseCase()
        let taskManageViewModel = TaskManageViewModel(selectedIndex: index, selectedTask: fetchedTask, manageType: .detail, taskManageUseCase: taskManageUseCase)
        
        presentTaskManageView?(taskManageViewModel)
    }
    
    func count(of state: TaskState) -> Int {
        return tasks.filter { $0.state == state }.count
    }
}
