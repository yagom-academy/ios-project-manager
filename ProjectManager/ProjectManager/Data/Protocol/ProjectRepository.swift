//
//  ProjectRepository.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/19.
//

protocol ProjectRepository {
    mutating func create(data: ProjectModel)
    func read() -> [ProjectModel]
    mutating func update(id: String,
                         data: ProjectModel)
    mutating func delete(id: String)
}
