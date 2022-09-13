//
//  ProjectDAO.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/08.
//

import Foundation

struct ProjectDAO: ProjectManagerDataProtocol {
    private var data = [
        ProjectDTO(id: UUID().description,
                title: "test",
                body: "testBody",
                date: Date(),
                workState: .todo),
        ProjectDTO(id: UUID().description,
                title: "test",
                body: "testBody",
                date: Date(),
                workState: .todo),
        ProjectDTO(id: UUID().description,
                title: "test",
                body: "testBody",
                date: Date(),
                workState: .todo),
        ProjectDTO(id: UUID().description,
                title: "test",
                body: "testBody",
                date: Date(),
                workState: .done),
        ProjectDTO(id: UUID().description,
                title: "test",
                body: "testBody",
                date: Date(),
                workState: .done)
    ]
    
    mutating func append(work: ProjectDTO) {
        data.append(work)
    }
                    
    func read() -> [ProjectDTO] {
        return data
    }
    
    func read(workState: ProjectState) -> [ProjectDTO] {
        return data.filter { $0.workState == workState }
    }
    
    mutating func update(id: String, work: ProjectDTO) {
        delete(id: id)
        data.append(work)
    }
    
    mutating func delete(id: String) {
        data = data.filter { $0.id != id }
    }
}
