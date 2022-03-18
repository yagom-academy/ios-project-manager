//
//  ProjectSource.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/06.
//

import Foundation

final class ProjectSource<T: Hashable & CustomStringConvertible>: LocalDataBase {
    
    typealias Item = Project
    
    // MARK: - Property
    private var projects: [String: Project] = [:]
    
    // MARK: - Method
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
    
    func read<T>(of identifier: T) -> Project? where T : Hashable & CustomStringConvertible {
        let identifierString = String(describing: identifier)
        return projects[identifierString]
    }
    
    func read(of status: Status) -> [Project]? {
        return projects.values.filter { project in project.status == status }
    }
    
    func update<T>(
        of identifier: T,
        with content: [String : Any]
    ) where T : Hashable & CustomStringConvertible {
        let identifierString = String(describing: identifier)
        
        guard var updatingProject = projects[identifierString] else {
            return
        }
        
        updatingProject.updateContent(with: content)
        projects.updateValue(updatingProject, forKey: identifierString)
    }
    
    func update<T>(
        of identifier: T,
        with status: Status
    ) where T : Hashable & CustomStringConvertible {
        let identifierString = String(describing: identifier)
        guard var updatingProject = projects[identifierString] else {
            return
        }
        
        updatingProject.updateStatus(with: status)
        projects.updateValue(updatingProject, forKey: identifierString)
    }
    
    func delete<T>(of identifier: T) where T : Hashable & CustomStringConvertible  {
        let identifierString = String(describing: identifier)
        projects.removeValue(forKey: identifierString)
    }
}
