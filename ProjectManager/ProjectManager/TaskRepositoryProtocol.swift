//
//  TaskRepositoryProtocol.swift
//  ProjectManager
//
//  Created by 이예은 on 2022/09/15.
//

import Foundation

protocol TaskRepositoryProtocol {
    func insertContent(model: TaskModelDTO)
    func fetch() -> [TaskModelDTO]
    func update(model: TaskModelDTO)
    func delete(model: TaskModelDTO)
}
