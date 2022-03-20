//
//  ProjectManager.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/06.
//

import Foundation

final class ProjectManager {
    
    // MARK: - Property
    private let projectSource = ProjectCoreDataManager()
    
    // MARK: - Method
    func create(with content: [String: Any]) {
        projectSource.create(with: content)
    }
    
    func readProject(of identifier: String) -> Project? {
        return projectSource.read(of: identifier)
    }
    
    func readProject(of status: Status) -> [Project]? {
        return projectSource.read(of: status)
    }
    
    func updateProjectContent(of identifier: String, with content: [String: Any]) {
        projectSource.update(of: identifier, with: content)
    }
    
    func updateProjectStatus(of identifier: String, with status: Status) {
        projectSource.update(of: identifier, with: status)
    }
    
    func delete(of identifier: String) {
        projectSource.delete(of: identifier)
    }
}
