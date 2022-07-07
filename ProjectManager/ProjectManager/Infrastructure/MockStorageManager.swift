//
//  MockStorageManager.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/07.
//

import Foundation
import RxSwift
import RxRelay

final class MockStorageManager {
    static let shared = MockStorageManager()
    private init() {}
    
    private var projects: [ProjectContent] = []
    var projectEntity = BehaviorRelay<[ProjectContent]>(value: [])
}

extension MockStorageManager {
    func creat(projectContent: ProjectContent) {
        projects.append(projectContent)
        
        projectEntity.accept(projects)
    }
    
    func read() -> [ProjectContent] {
        return projectEntity.value
    }
    
    func update(projectContent: ProjectContent) {
        projects.enumerated()
            .forEach { (index, project) in
                if project.id == projectContent.id {
                    changeProjectEntity(index, projectContent)
                }
            }
        
        projectEntity.accept(projects)
    }
    
    private func changeProjectEntity(_ index: Int, _ projectContent: ProjectContent) {
        projects[index] = projectContent
    }
    
    func delete(projectContent: ProjectContent) {
        projects.enumerated()
            .forEach { (index, project) in
                if project.id == projectContent.id {
                    removeProjectEntity(index)
                }
            }
        
        projectEntity.accept(projects)
    }
    
    private func removeProjectEntity(_ index: Int) {
        projects.remove(at: index)
        projectEntity.accept(projects)
    }
}
