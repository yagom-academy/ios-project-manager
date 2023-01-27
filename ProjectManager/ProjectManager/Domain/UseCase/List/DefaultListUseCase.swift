//
//  DefaultListUseCase.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/17.
//

import Foundation

final class DefaultListUseCase: ListUseCase {

    func makeProject(title: String, description: String, deadline: Date, identifier: UUID?) -> Project {
        guard let identifier = identifier else {
            return Project(title: title, description: description, deadline: deadline)
        }
        
        return Project(title: title, description: description, deadline: deadline, identifier: identifier)
    }

    func editProject(list: [Project], project: Project) -> [Project] {
        var list = list
        guard let index = list.firstIndex(where: { $0.identifier == project.identifier }) else {
            return list
        }
        list[index] = project
        
        return list
    }

    func removeProject(list: [Project], index: Int) -> [Project] {
        var list = list
        list.remove(at: index)
        
        return list
    }
}
