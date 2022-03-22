//
//  InMemoryDataManager.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/06.
//

import Foundation

final class InMemoryDataManager {

    // MARK: - Property
    private var projects: [String: Project] = [:]
    
}

// MARK: - DataSource
extension InMemoryDataManager: DataSource {
    
    func create(with content: [String: Any]) {
        guard let identifier = content["identifier"] as? String else {
            return
        }
        let newProject = Project(identifier: identifier,
                                 title: content["title"] as? String,
                                 deadline: content["deadline"] as? Date,
                                 description: content["description"] as? String,
                                 status: content["status"] as? Status)
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
