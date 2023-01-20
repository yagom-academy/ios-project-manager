//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Hamo, Wonbi on 2023/01/16.
//

import Foundation

protocol MainViewModelProtocol {
    var models: [Project] { get set }
    var closure: (([Project]) -> Void)? { get set }
    
    func createProject(title: String, deadline: Calendar, description: String)
    func updateProject()
    func deleteProject(with project: Project)
}

final class MainViewModel: MainViewModelProtocol {
    var models: [Project] = [] {
        didSet {
            closure?(models)
        }
    }

    var closure: (([Project]) -> Void)?
    
    func createProject(title: String, deadline: Calendar, description: String) {
        let project = Project(
            title: title,
            deadline: deadline,
            description: description,
            state: .todo
        )
        
        models.append(project)
    }
    
    func updateProject() {
        //
    }
    
    func deleteProject(with project: Project) {
        models = models.filter { $0.id != project.id }
    }
    
    private func changeDateString(from date: Date) -> String {
        date.description
    }
}
