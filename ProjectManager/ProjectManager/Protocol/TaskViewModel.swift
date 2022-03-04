//
//  TaskListViewModel.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/02.
//

import Foundation

protocol TaskViewModel {
    func create(with task: Task)
    func update(with task: Task)
    func delete(with task: Task)
    func changeState(of task: Task, to state: TaskState)
    func fetch(at index: Int, with state: TaskState) throws -> Task
    func didSelectRow(at index: Int, with state: TaskState)
    func count(of state: TaskState) -> Int
}
