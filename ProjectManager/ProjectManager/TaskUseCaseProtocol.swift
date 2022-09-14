//
//  TaskUseCaseProtocol.swift
//  ProjectManager
//
//  Created by 이예은 on 2022/09/15.
//

import Foundation

protocol TaskUseCaseProtocol {
    func insertContents(data: TaskModelDTO)
    func fetch() -> [TaskModelDTO]
    func update(data: TaskModelDTO)
    func delete(data: TaskModelDTO)
}
