//
//  ToDoManageable.swift
//  ProjectManager
//
//  Created by 로빈솜 on 2023/01/11.
//

import Foundation

protocol ToDoManageable {
    func create() -> ToDo
    func save(id: UUID, title: String, description: String, deadline: Date)
    func fetch(id: UUID) -> ToDo?
    func delete(id: UUID)
}
