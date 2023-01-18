//
//  ListUseCase.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/17.
//

protocol ListUseCase {
    
    var listOutput: ListOutput? { get set }
    func fetchProjectList(state: State) -> [Project]
    func saveProject(_ project: Project)
    func removeProject(_ project: Project)
}
