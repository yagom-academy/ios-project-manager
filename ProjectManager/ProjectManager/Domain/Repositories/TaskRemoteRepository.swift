//
//  TaskRemoteRepository.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/05.
//

import Foundation

protocol TaskRemoteRepository {
    func fetchAll(by user: User) async -> [Task]
    func syncronize(from localTasks: [Task], by user: User)
    func save(_ task: Task, by user: User)
    func update(id: UUID, new task: Task, by user: User)
    func delete(_ task: Task, by user: User)
}
