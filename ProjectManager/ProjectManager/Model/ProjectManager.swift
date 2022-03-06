//
//  ProjectManager.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/06.
//

import Foundation

final class ProjectManager {
    
    // MARK: - Property
    private let projectSource = ProjectSource<UUID>()
    
    // MARK: - Method
    func create() {
        projectSource.create()
    }
    
    func readProject(of identifier: UUID) -> Project? {
        return projectSource.read(of: identifier)
    }
    
    func readProject(of status: Status) -> [Project]? {
        return projectSource.read(of: status)
    }
    
    func updateProject(of identifier: UUID, with content: [String: Any]) {
        projectSource.update(of: identifier, with: content)
    }
    
    func updateProjectStatus(of identifier: UUID, with status: Status) {
        projectSource.update(of: identifier, with: status)
    }
    
    func delete(of identifier: UUID) {
        projectSource.delete(of: identifier)
    }
}
