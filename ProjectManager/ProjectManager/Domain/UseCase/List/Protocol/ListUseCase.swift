//
//  ListUseCase.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/17.
//

protocol ListUseCase {
    
    func fetchProjectList(state: State) -> [Project]
    func addNewProject(_ project: Project)
    func editProject(_ project: Project)
    func removeProject(_ project: Project)
}
