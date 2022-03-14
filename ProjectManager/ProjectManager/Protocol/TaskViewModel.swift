//
//  TaskListViewModel.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/02.
//

import Foundation

protocol TaskViewModel {
    var presentErrorAlert: ((Error) -> Void)? { get set }
    var reloadTableView: (() -> Void)? { get set }
    var deleteRows: ((Int, TaskState) -> Void)? { get set }
    var reloadRows: ((Int, TaskState) -> Void)? { get set }
    var moveRows: ((Int, TaskState, TaskState) -> Void)? { get set }
    var reloadTableViews: (() -> Void)? { get set }
    var didSelectRows: ((Int, Task) -> Void)? { get set }
    
    func onViewWillAppear()
    func createTask(title: String, description: String, deadline: Date)
    func updateTask(at index: Int, title: String, description: String, deadline: Date, from state: TaskState)
    func deleteTask(at index: Int, from state: TaskState)
    func moveTask(at index: Int, from oldState: TaskState, to newState: TaskState)
    func task(at index: Int, from state: TaskState) -> TaskCell?
    func selectTask(at index: Int, from state: TaskState)
    func count(of state: TaskState) -> Int
}
