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
    var presentTaskManageView: ((TaskManageViewModel) -> Void)? { get set }
    var taskCount: (([(count: Int, state: TaskState)]) -> Void)? { get set }
    
    func onViewWillAppear()
    func createTask(with task: Task)
    func updateTask(at index: Int, task: Task)
    func deleteTask(at index: Int, from state: TaskState)
    func moveTask(at index: Int, from oldState: TaskState, to newState: TaskState)
    func task(at index: Int, from state: TaskState) -> TaskCellViewModel?
    func selectTask(at index: Int, from state: TaskState)
    func count(of state: TaskState) -> Int
}
