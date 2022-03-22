//
//  TaskListUseCase.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/02.
//

import Foundation

protocol TaskListUseCase {
    func create(with task: Task)
    func fetchAll() -> [Task]
    func fetch(at index: Int, from state: TaskState) -> Task?
    func update(at index: Int, with task: Task)
    func delete(at index: Int, from state: TaskState)
    func changeState(at index: Int, from oldState: TaskState, to newState: TaskState)
}
