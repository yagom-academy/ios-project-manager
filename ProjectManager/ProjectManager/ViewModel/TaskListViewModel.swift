//
//  TaskListViewModel.swift
//  ProjectManager
//
//  Created by 김준건 on 2021/11/05.
//

import SwiftUI

protocol TaskListViewModelProtocol {
    var tasks: [TLTask] { get set }
    func fetchTasks()
    func filterStatus(of task: [TLTask])
    func addNewTask(title: String, message: String, date: Date, status: Status)
    func updateTaskList(task: TLTask?, status: Status, title: String, message: String, date: Date)
}

final class TaskListViewModel: ObservableObject {
    @Published var tasks: [TLTask] = []
    private var todoTasks: [TLTask] = []
    private var doingTasks: [TLTask] = []
    private var completeTasks: [TLTask] = []
    
    private var dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol = DataManager.shared) {
        self.dataManager = dataManager
        fetchTasks()
        filterStatus(of: tasks)
    }
}

extension TaskListViewModel: TaskListViewModelProtocol {
    func fetchTasks() {
        tasks = dataManager.fetchTask
    }
    
    func filterStatus(of task: [TLTask]) {
        Status.allCases.forEach { status in
            switch status {
            case .TODO:
                todoTasks = tasks.filter { $0.status == .TODO }.sorted{ $0.date < $1.date}
            case .DOING:
                doingTasks = tasks.filter { $0.status == .DOING }.sorted{ $0.date < $1.date}
            case .DONE:
                completeTasks = tasks.filter { $0.status == .DONE }.sorted{ $0.date < $1.date}
            }
        }
    }
    
    func addNewTask(title: String, message: String, date: Date, status: Status) {
        dataManager.addTask(title: title, message: message, date: date, status: status)
        fetchTasks()
    }
    
    func updateTaskList(task: TLTask?, status: Status, title: String, message: String, date: Date) {
        dataManager.updateTaskList(task: task, status: status, title: title, message: message, date: date)
        fetchTasks()
    }
}

