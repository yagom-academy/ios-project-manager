//
//  ProjectUseCase.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/19.
//

protocol ProjectUseCase {
    mutating func create(data: ProjectViewModel)
    func read() -> [ProjectViewModel]
    mutating func update(id: String,
                         data: ProjectViewModel)
    mutating func delete(id: String)
}
