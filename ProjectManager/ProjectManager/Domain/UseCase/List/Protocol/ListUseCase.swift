//
//  ListUseCase.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/17.
//

import Foundation

protocol ListUseCase {
    
    func makeProject(title: String, description: String, deadline: Date, identifier: UUID?) -> Project
    func editProject(list: [Project], project: Project) -> [Project]
    func removeProject(list: [Project], index: Int) -> [Project]
}
