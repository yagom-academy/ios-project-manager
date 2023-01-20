//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Hamo, Wonbi on 2023/01/16.
//

import Foundation

protocol MainViewModelProtocol: ViewModelDelegate {
    var models: [Project] { get set }
    var closure: (([Project]) -> Void)? { get set }
    
    func deleteProject(with project: Project)
}

final class MainViewModel: MainViewModelProtocol {
    var models: [Project] = [] {
        didSet {
            closure?(models)
        }
    }

    var closure: (([Project]) -> Void)?
    
    func deleteProject(with project: Project) {
        models = models.filter { $0.id != project.id }
    }
    
    private func changeDateString(from date: Date) -> String {
        date.description
    }
}

extension MainViewModel {
    func addProject(_ project: Project?) {
        guard let project = project else { return }

        models.append(project)
    }
    
    func updateProject(_ project: Project?) {
        guard let project = project,
              let index = models.firstIndex(where: { $0.id == project.id })
        else {
            return
        }
        
        models[index] = project
    }
}
