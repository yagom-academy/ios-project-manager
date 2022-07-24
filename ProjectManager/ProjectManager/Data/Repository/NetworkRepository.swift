//
//  NetworkRepository.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/21.
//

import Foundation
import RxSwift

final class NetworkRepository {
    static let shared = NetworkRepository()
    
    let networkManager = NetworkManager()
    
    private init() { }
}

extension NetworkRepository {
    func update(repository: ProjectRepository) {
        let projects = repository.read().value.compactMap {
            parse(from: $0)
        }
        
        networkManager.update(projects: projects)
    }
    
    func read(repository: ProjectRepository) -> Disposable {
        return networkManager.read()
            .subscribe(onNext: {[weak self] data in
                self?.synchronize(with: data, to: repository)
            })
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
        guard let status = ProjectStatus.convert(statusString: project.status),
              let id = UUID(uuidString: project.id),
              let deadline = DateFormatter().formatted(string: project.deadline) else {
            return nil
        }
        
        let title = project.title
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
        return ProjectDTO(
            id: projectContent.id.uuidString,
            status: projectContent.status.string,
            title: projectContent.title,
            deadline: projectContent.deadline,
            body: projectContent.body
        )
    }
}
