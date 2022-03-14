//
//  TaskListViewModel.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/02.
//

import Foundation

protocol TaskViewModel {
    var presentErrorAlert: ((Error) -> Void)? { get set }
    var taskDidCreated: (() -> Void)? { get set }
    var taskDidDeleted: ((Int, TaskState) -> Void)? { get set }
    var taskDidChanged: ((Int, TaskState) -> Void)? { get set }
    var taskDidMoved: ((Int, TaskState, TaskState) -> Void)? { get set }
    var tasksDidUpdated: (() -> Void)? { get set }
    var didSelectTask: ((Int, Task) -> Void)? { get set }
    
    func viewWillAppear()
    func createTask(title: String, description: String, deadline: Date)
    func updateRow(at index: Int, title: String, description: String, deadline: Date, from state: TaskState)
    func deleteRow(at index: Int, from state: TaskState)
    func move(at index: Int, from oldState: TaskState, to newState: TaskState)
    func task(at index: Int, from state: TaskState) -> TaskCell?
    func didSelectRow(at index: Int, from state: TaskState)
    func count(of state: TaskState) -> Int
}
