//
//  TaskMangeable.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/02.
//

import Foundation

protocol TaskMangeable {
    func create(title: String, description: String, deadline: Date)
    func fetchAll() -> [Task]
    func fetch(at index: Int, from state: TaskState) -> Task?
    func update(at index: Int, title: String, description: String, deadline: Date, from state: TaskState)
    func delete(at index: Int, from state: TaskState)
    func changeState(at index: Int, to state: TaskState)
}
