//
//  ProjectUseCase.swift
//  ProjectManager
//
//  Created by Erick on 2023/09/21.
//

import Foundation

protocol ProjectUseCase {
    func readProjects() -> Published<[Project]>.Publisher
    func storeProject(_ project: Project)
    func deleteProject(_ project: Project)
}

final class DefaultProjectUseCase: ProjectUseCase {
    
    // MARK: - Private Property
    @Published private var projectRepository: [Project] = []
    
    // MARK: - Project CRUD
    func readProjects() -> Published<[Project]>.Publisher {
        return $projectRepository
    }
    
    func storeProject(_ project: Project) {
        if let index = projectRepository.firstIndex(where: { $0.id == project.id }) {
            projectRepository[index] = project
        } else {
            projectRepository.append(project)
        }
    }
    
    func deleteProject(_ project: Project) {
        if let index = projectRepository.firstIndex(where: { $0.id == project.id }) {
            projectRepository.remove(at: index)
        }
    }
}
