//
//  MockStorageManager.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/07.
//

import Foundation

final class MockStorageManager {
    static let shared = MockStorageManager()
    private init() {}
    
    private var projectEntity: [ProjectItem] = []
    
}

extension MockStorageManager {
    func creat(projectContent: ProjectContent) {
        guard let projectItem = projectContent.asProjectItem() else {
            return
        }
        
        projectEntity.append(projectItem)
    }
    
    func read() -> [ProjectItem] {
        return projectEntity
    }
    
    func update(projectContent: ProjectContent) {
        projectEntity.enumerated()
            .forEach { (index, project) in
                if project.id == projectContent.id {
                    changeProjectEntity(index, projectContent)
                }
            }
    }
    
    private func changeProjectEntity(_ index: Int, _ projectContent: ProjectContent) {
        guard let newProjectEntity = projectContent.asProjectItem() else {
            return
        }
        projectEntity[index] = newProjectEntity
    }
    
    func delete(projectContent: ProjectContent) {
        projectEntity.enumerated()
            .forEach { (index, project) in
                if project.id == projectContent.id {
                    removeProjectEntity(index)
                }
            }
    }
    
    private func removeProjectEntity(_ index: Int) {
        projectEntity.remove(at: index)
    }
}
