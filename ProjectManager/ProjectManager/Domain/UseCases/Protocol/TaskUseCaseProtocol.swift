//
//  TaskUseCaseProtocol.swift
//  ProjectManager
//
//  Created by 이예은 on 2022/09/15.
//

import Foundation

protocol TaskUseCaseProtocol {
    func insertContent(task: Task)
    func fetch() -> [Task]
    func update(task: Task)
    func delete(task: Task)
}
