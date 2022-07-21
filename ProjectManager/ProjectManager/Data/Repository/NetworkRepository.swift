//
//  NetworkRepository.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/21.
//

import Foundation

final class NetworkRepository {
    let networkManager = NetworkManager()
    
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
}
