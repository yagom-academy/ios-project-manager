//
//  MockStorageManager.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/07.
//

@testable import ProjectManager
import RxSwift
import RxRelay

final class MockRepository {
    static let shared = MockRepository()
    
    private init() { }
    
    private var projectEntities = BehaviorRelay<[ProjectEntity]>(value: [])
}

extension MockRepository: Storagable {
    func create(projectContent: ProjectEntity) {
        var currentProject = read().value
        currentProject.append(projectContent)
        projectEntities.accept(currentProject)
    }
    
    func create(projectContents: [ProjectEntity]) {
        projectEntities.accept(projectContents)
    }
    
    func read() -> BehaviorRelay<[ProjectEntity]> {
        return projectEntities
    }
    
    func read(id: UUID?) -> ProjectEntity? {
        return projectEntities.value.filter { $0.id == id }.first
    }
    
    func update(projectContent: ProjectEntity) {
        let projects = projectEntities.value
        
        if let indexToUpdated = projects.firstIndex(where: { $0.id == projectContent.id}) {
            var projectsToUpdate = projectEntities.value
            
            projectsToUpdate[indexToUpdated] = projectContent
            projectEntities.accept(projectsToUpdate)
        }
    }
    
    func delete(projectContentID: UUID?) {
        let projects = projectEntities.value
        
        if let indexToDelete = projects.firstIndex(where: { $0.id == projectContentID}) {
            var projectsToDelete = projectEntities.value
            
            projectsToDelete.remove(at: indexToDelete)
            projectEntities.accept(projectsToDelete)
        }
    }
    
    func deleteAll() {
        projectEntities.accept([])
    }
}
