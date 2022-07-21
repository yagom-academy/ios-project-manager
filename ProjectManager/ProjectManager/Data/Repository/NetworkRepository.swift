//
//  NetworkRepository.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/21.
//

import Foundation

final class NetworkRepository {
    let networkManager = NetworkManager()
}

extension NetworkRepository {
    func update(repository: ProjectRepository) {
        let projects = repository.read().value.compactMap {
            parse(from: $0)
        }
        
        networkManager.update(projects: projects)
    }
    
    func read(repository: ProjectRepository) {
        networkManager.read { [weak self] data in
            switch data {
            case .failure:
                break
            case .success(let projects):
                self?.synchronize(with: projects, to: repository)
            }
        }
    }
    
    private func synchronize(
        with projects: [ProjectDTO],
        to repository: ProjectRepository
    ) {
        let formattedProjects = projects.compactMap {
            parse(from: $0)
        }
        
        repository.deleteAll()
        repository.create(projectContents: formattedProjects)
    }
}

extension NetworkRepository {
    func parse(from project: ProjectDTO) -> ProjectContent? {
        guard let status = ProjectStatus.convert(statusString: project.status) else {
            return nil
        }
        
        let id = project.id
        let title = project.title
        let deadline = project.deadline
        let body = project.body
        
        return ProjectContent(
            id: id,
            status: status,
            title: title,
            deadline: deadline,
            body: body
        )
    }
    
    func parse(from projectContent: ProjectContent) -> ProjectDTO? {
        guard let deadline = DateFormatter().formatted(string: projectContent.deadline) else {
            return nil
        }
        
        return ProjectDTO(
            id: projectContent.id,
            status: projectContent.status.string,
            title: projectContent.title,
            deadline: deadline,
            body: projectContent.body
        )
    }
}
