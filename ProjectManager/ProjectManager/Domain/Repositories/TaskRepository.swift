//
//  TaskRepository.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/03.
//

import Foundation

protocol TaskRepository {
    func fetchAll() -> [Task]
    func save(_ task: Task)
    func update(id: UUID, new task: Task)
    func delete(task: Task)
    func fetch(id: UUID) -> Task?
}
