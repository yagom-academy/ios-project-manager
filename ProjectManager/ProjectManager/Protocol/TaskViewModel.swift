//
//  TaskListViewModel.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/02.
//

import Foundation

protocol TaskViewModel {
    func createTask(title: String, description: String, deadline: Date)
    func updateRow(at index: Int, title: String, description: String, deadline: Date, state: TaskState)
    func deleteRow(at index: Int, from state: TaskState)
    func move(at index: Int, to state: TaskState)
    func task(at index: Int, from state: TaskState)
    func didSelectRow(at index: Int, from state: TaskState)
    func count(of state: TaskState) -> Int
}
