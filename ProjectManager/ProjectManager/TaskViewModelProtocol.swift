//
//  TaskViewModelProtocol.swift
//  ProjectManager
//
//  Created by 이예은 on 2022/09/15.
//

import Foundation

protocol TaskViewModelProtocol {
    func insertContents(data: TaskModelDTO)
    func fetch() -> [TaskModelDTO]
    func update(data: TaskModelDTO)
    func delete(data: TaskModelDTO)
    func changeState(data: TaskModelDTO, to state: ProjectState)
}
