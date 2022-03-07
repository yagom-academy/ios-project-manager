//
//  TaskRepository.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/02.
//

import Foundation

protocol TaskRepository {
    func create(with task: Task)
    func fetchAll() -> [Task]
    func update(with task: Task)
    func delete(with task: Task)
}
