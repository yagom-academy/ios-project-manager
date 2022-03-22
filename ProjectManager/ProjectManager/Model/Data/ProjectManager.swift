//
//  ProjectManager.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/06.
//

import Foundation

final class ProjectManager {
    
    // MARK: - Property
    private var projectSource: DataSource? = ProjectFirestoreManager()
    
    // MARK: - Method
    func create(with content: [String: Any]) {
        self.projectSource?.create(with: content)
    }
    
    func readProject(
        of identifier: String,
        completion: @escaping (Result<Project?, Error>
        ) -> Void) {
        self.projectSource?.read(of: identifier, completion: completion)
    }
    
    func readProject(
        of status: Status,
        completion: @escaping (Result<[Project]?, Error>
    ) -> Void)  {
        self.projectSource?.read(of: status, completion: completion)
    }
    
    func updateProjectContent(of identifier: String, with content: [String: Any]) {
        self.projectSource?.updateContent(of: identifier, with: content)
    }
    
    func updateProjectStatus(of identifier: String, with status: Status) {
        self.projectSource?.updateStatus(of: identifier, with: status)
    }
    
    func delete(of identifier: String) {
        self.projectSource?.delete(of: identifier)
    }
}
