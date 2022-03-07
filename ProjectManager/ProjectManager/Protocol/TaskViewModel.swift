//
//  TaskListViewModel.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/02.
//

import Foundation

protocol TaskViewModel {
    func createTask(title: String, description: String, deadline: Date)
    func updateRow(with task: Task)
    func deleteRow(with task: Task)
    func move(task: Task, to state: TaskState)
    func task(at index: Int, with state: TaskState, completion: (Task) -> Void)
    func didSelectRow(at index: Int, with state: TaskState)
    func count(of state: TaskState) -> Int
}
