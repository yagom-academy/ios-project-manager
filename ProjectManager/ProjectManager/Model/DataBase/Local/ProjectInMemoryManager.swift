//
//  ProjectInMemoryManager.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/06.
//

import Foundation

final class ProjectInMemoryManager {

    // MARK: - Property
    private var projects: [String: Project] = [:]
    
}

// MARK: - DataSource
extension ProjectInMemoryManager: DataSource {
    
    var type: DataSourceType {
        get {
            return .inMemory
        }
    }
    
    func create(with content: [String: Any]) {
        guard let identifier = content[ProjectKey.identifier.rawValue] as? String else {
            return
        }
        let newProject = Project(identifier: identifier,
                                 title: content[ProjectKey.title.rawValue] as? String,
                                 deadline: content[ProjectKey.deadline.rawValue] as? Date,
                                 description: content[ProjectKey.description.rawValue] as? String,
                                 status: content[ProjectKey.status.rawValue] as? Status)
        projects.updateValue(newProject, forKey: identifier)
    }
    
    func read(of identifier: String, completion: @escaping (Result<Project?, Error>) -> Void) {
        completion(.success(projects[identifier]))
    }
    
    func read(of group: Status, completion: @escaping (Result<[Project]?, Error>) -> Void) {
        let projects = projects.values.filter { project in project.status == group }
        completion(.success(projects))
    }
    
    func updateContent(of identifier: String, with content: [String : Any]) {
        guard var updatingProject = projects[identifier] else {
            return
        }
        
        updatingProject.updateContent(with: content)
        projects.updateValue(updatingProject, forKey: identifier)
    }
    
    func updateStatus(of identifier: String, with status: Status) {
        guard var updatingProject = projects[identifier] else {
            return
        }
        
        updatingProject.updateStatus(with: status)
        projects.updateValue(updatingProject, forKey: identifier)
    }
   
    func delete(of identifier: String) {
        projects.removeValue(forKey: identifier)
    }
}
