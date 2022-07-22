//
//  PersistentStorageManager.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/19.
//

import RxSwift
import RxRelay

final class PersistentRepository {
    static let shared = PersistentRepository()
    private let persistentManager = PersistentManager()
    
    private init() { }
    
    private lazy var projectEntities = BehaviorRelay<[ProjectContent]>(value: fetchCoreDate())
    
    private func fetchCoreDate() -> [ProjectContent] {
        let currentProjects = persistentManager.read()
        let contents = currentProjects.compactMap { parse(from: $0) }
        
        return contents
    }
}

extension PersistentRepository: Storagable {
    func create(projectContent: ProjectContent) {
        createCoreDate(newProjectContent: projectContent)
        createProjectEntities(newProjectContent: projectContent)
    }
    
    func create(projectContents: [ProjectContent]) {
        createCoreDate(newProjectContents: projectContents)
        createProjectEntities(newProjectContents: projectContents)
    }
    
    func read() -> BehaviorRelay<[ProjectContent]> {
        return projectEntities
    }
    
    func read(id: UUID?) -> ProjectContent? {
        return projectEntities.value.filter { $0.id == id }.first
    }
    
    func update(projectContent: ProjectContent) {
        updateCoreDate(newProjectContent: projectContent)
        updateProjectEntities(newProjectContent: projectContent)
    }
    
    func delete(projectContentID: UUID?) {
        deleteCoreDate(projectContentID: projectContentID)
        deleteProjectEntities(projectContentID: projectContentID)
    }
    
    func deleteAll() {
        deleteAllCoreDate()
        deleteAllProjectEntities()
    }
}

extension PersistentRepository {
    private func createCoreDate(newProjectContent: ProjectContent) {
        guard let newProject = parse(from: newProjectContent) else {
            return
        }
        
        persistentManager.create(project: newProject)
    }
    
    private func createProjectEntities(newProjectContent: ProjectContent) {
        var projectContents = projectEntities.value
        
        projectContents.append(newProjectContent)
        projectEntities.accept(projectContents)
    }
    
    private func createCoreDate(newProjectContents: [ProjectContent]) {
        let newProjects = newProjectContents.compactMap {
            parse(from: $0)
        }
        
        persistentManager.create(projects: newProjects)
    }
    
    private func createProjectEntities(newProjectContents: [ProjectContent]) {
        projectEntities.accept(newProjectContents)
    }
    
    private func updateCoreDate(newProjectContent: ProjectContent) {
        guard let newProject = parse(from: newProjectContent) else {
            return
        }
        
        persistentManager.update(project: newProject)
    }
    
    private func updateProjectEntities(newProjectContent: ProjectContent) {
        let projects = projectEntities.value
        
        if let indexToUpdated = projects.firstIndex(where: { $0.id == newProjectContent.id}) {
            var projectsToUpdate = projectEntities.value
            
            projectsToUpdate[indexToUpdated] = newProjectContent
            projectEntities.accept(projectsToUpdate)
        }
    }
    
    private func deleteCoreDate(projectContentID: UUID?) {
        persistentManager.delete(projectContentID: projectContentID)
    }
    
    private func deleteProjectEntities(projectContentID: UUID?) {
        let projects = projectEntities.value
        
        if let indexToDelete = projects.firstIndex(where: { $0.id == projectContentID}) {
            var projectsToDelete = projectEntities.value
            
            projectsToDelete.remove(at: indexToDelete)
            projectEntities.accept(projectsToDelete)
        }
    }
    
    private func deleteAllCoreDate() {
        persistentManager.deleteAll()
    }
    
    private func deleteAllProjectEntities() {
        projectEntities.accept([])
    }
}

extension PersistentRepository {
    func parse(from project: Project) -> ProjectContent? {
        guard let id = project.id,
              let status = ProjectStatus.convert(statusString: project.status),
              let title = project.title,
              let deadline = project.deadline,
              let body = project.body else {
            return nil
        }
        
        return ProjectContent(
            id: id,
            status: status,
            title: title,
            deadline: deadline,
            body: body
        )
    }
    
    func parse(from projectContent: ProjectContent) -> ProjectDTO? {
        return ProjectDTO(
            id: projectContent.id.uuidString,
            status: projectContent.status.string,
            title: projectContent.title,
            deadline: projectContent.deadline,
            body: projectContent.body
        )
    }
}
