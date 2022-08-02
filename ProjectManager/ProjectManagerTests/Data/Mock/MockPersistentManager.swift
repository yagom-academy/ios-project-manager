//
//  MockPersistentManager.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/07.
//

@testable import ProjectManager
import Foundation

final class MockCoreData {
    var projects: [ProjectDTO] = []
}

final class MockPersistentManager {
    private let database = MockCoreData()
}

extension MockPersistentManager: PersistentManagerProtocol {
    func create(project: ProjectDTO) {
        database.projects.append(project)
    }
    
    func create(projects: [ProjectDTO]) {
        database.projects = projects
    }
    
    func read() -> [ProjectDTO] {
        return database.projects
    }
    
    func read(projectEntityID: UUID?) -> ProjectDTO? {
        if let indexToRead = database.projects.firstIndex(where: { $0.id == projectEntityID?.uuidString}) {
            return database.projects[indexToRead]
        }
        return nil
    }
    
    func update(project: ProjectDTO) {
        if let indexToUpdate = database.projects.firstIndex(where: { $0.id == project.id}) {
            database.projects[indexToUpdate] = project
        }
    }
    
    func delete(projectEntityID: UUID?) {
        if let indexToDelete = database.projects.firstIndex(where: { $0.id == projectEntityID?.uuidString}) {
            database.projects.remove(at: indexToDelete)
        }
    }
    
    func deleteAll() {
        database.projects = []
    }
}
