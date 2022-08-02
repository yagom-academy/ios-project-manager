//
//  NetworkRepository.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/21.
//

import Foundation
import RxSwift

protocol NetworkRepositoryProtocol {
    func update(repository: PersistentRepositoryProtocol)
    func read(repository: PersistentRepositoryProtocol) -> Disposable
}

extension NetworkRepositoryProtocol {
    func parse(from project: ProjectDTO) -> ProjectEntity? {
        guard let status = ProjectStatus.convert(statusString: project.status),
              let id = UUID(uuidString: project.id),
              let unixTime = Double(project.deadline) else {
                  return nil
              }
        
        let deadline = Date(timeIntervalSince1970: unixTime)
        let title = project.title
        let body = project.body
        
        return ProjectEntity(
            id: id,
            status: status,
            title: title,
            deadline: deadline,
            body: body
        )
    }
    
    func parse(from projectEntity: ProjectEntity) -> ProjectDTO? {
        guard let date = DateFormatter().formatted(string: projectEntity.deadline) else {
            return nil
        }
        
        let timeInterval = "\(date.timeIntervalSince1970)"
        
        return ProjectDTO(
            id: projectEntity.id.uuidString,
            status: projectEntity.status.string,
            title: projectEntity.title,
            deadline: timeInterval,
            body: projectEntity.body
        )
    }
}

final class NetworkRepository: NetworkRepositoryProtocol {
    private let networkManger: NetworkManagerProtocol
    
    init(networkManger: NetworkManagerProtocol) {
        self.networkManger = networkManger
    }
}

extension NetworkRepository {
    func update(repository: PersistentRepositoryProtocol) {
        let projects = repository.read().value.compactMap {
            parse(from: $0)
        }
        
        networkManger.update(projects: projects)
    }
    
    func read(repository: PersistentRepositoryProtocol) -> Disposable {
        return networkManger.read()
            .subscribe(onNext: {[weak self] data in
                self?.synchronize(with: data, to: repository)
            })
    }
    
    private func synchronize(
        with projects: [ProjectDTO],
        to repository: PersistentRepositoryProtocol
    ) {
        let formattedProjects = projects.compactMap {
            parse(from: $0)
        }
        
        repository.deleteAll()
        repository.create(projectEntities: formattedProjects)
    }
}
