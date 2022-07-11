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
    
    private var projectEntities = BehaviorRelay<[ProjectContent]>(value: [])
}

extension MockStorageManager {
    func create(projectContents: [ProjectContent]) {
        projectEntities.accept(projectContents)
    }
    
    func read() -> BehaviorRelay<[ProjectContent]> {
        return projectEntities
    }
    
    func update(projectContent: ProjectContent) {
        let projects = projectEntities.value
        if let indexToUpdated = projects.firstIndex(where: { $0.id == projectContent.id}) {
            var projectsToUpdate = projectEntities.value
            projectsToUpdate[indexToUpdated] = projectContent
            projectEntities.accept(projectsToUpdate)
        }
    }
    
    func delete(projectContent: ProjectContent) {
        let projects = projectEntities.value
        if let indexToDelete = projects.firstIndex(where: { $0.id == projectContent.id}) {
            var projectsToDelete = projectEntities.value
            projectsToDelete.remove(at: indexToDelete)
            projectEntities.accept(projectsToDelete)
        }
    }
}
