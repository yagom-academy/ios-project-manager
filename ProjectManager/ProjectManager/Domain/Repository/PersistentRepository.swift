//
//  PersistentRepository.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/12.
//

import RxSwift
import RxRelay

protocol PersistentRepositoryProtocol {
    func create(projectEntity: ProjectEntity)
    func create(projectEntities: [ProjectEntity])
    func read() -> BehaviorRelay<[ProjectEntity]>
    func read(projectEntityID: UUID?) -> ProjectEntity?
    func update(projectEntity: ProjectEntity)
    func delete(projectEntityID: UUID?)
    func deleteAll()
}

extension PersistentRepositoryProtocol {
    func parse(from project: ProjectDTO) -> ProjectEntity? {
        guard let id = UUID(uuidString: project.id),
              let status = ProjectStatus.convert(statusString: project.status),
              let deadline = DateFormatter().formatted(string: project.deadline) else {
            return nil
        }
        
        return ProjectEntity(
            id: id,
            status: status,
            title: project.title,
            deadline: deadline,
            body: project.body
        )
    }
    
    func parse(from projectEntity: ProjectEntity) -> ProjectDTO? {
        return ProjectDTO(
            id: projectEntity.id.uuidString,
            status: projectEntity.status.string,
            title: projectEntity.title,
            deadline: projectEntity.deadline,
            body: projectEntity.body
        )
    }
}

final class PersistentRepository: PersistentRepositoryProtocol {
    private let persistentManager: PersistentManagerProtocol
    private lazy var projectEntities = BehaviorRelay<[ProjectEntity]>(value: fetchCoreDate())
    
    init(persistentManager: PersistentManagerProtocol) {
        self.persistentManager = persistentManager
    }
    
    private func fetchCoreDate() -> [ProjectEntity] {
        let currentProjects = persistentManager.read()
        let contents = currentProjects.compactMap { parse(from: $0) }
        
        return contents
    }
}

extension PersistentRepository {
    func create(projectEntity: ProjectEntity) {
        createCoreDate(newProjectEntity: projectEntity)
        createProjectEntities(newProjectEntity: projectEntity)
    }
    
    func create(projectEntities: [ProjectEntity]) {
        createCoreDate(newProjectEntities: projectEntities)
        createProjectEntities(newProjectEntities: projectEntities)
    }
    
    func read() -> BehaviorRelay<[ProjectEntity]> {
        return projectEntities
    }
    
    func read(projectEntityID: UUID?) -> ProjectEntity? {
        return projectEntities.value.filter { $0.id == projectEntityID }.first
    }
    
    func update(projectEntity: ProjectEntity) {
        updateCoreDate(newProjectEntity: projectEntity)
        updateProjectEntities(newProjectEntity: projectEntity)
    }
    
    func delete(projectEntityID: UUID?) {
        deleteCoreDate(projectEntityID: projectEntityID)
        deleteProjectEntities(projectEntityID: projectEntityID)
    }
    
    func deleteAll() {
        deleteAllCoreDate()
        deleteAllProjectEntities()
    }
}

extension PersistentRepository {
    private func createCoreDate(newProjectEntity: ProjectEntity) {
        guard let newProject = parse(from: newProjectEntity) else {
            return
        }
        
        persistentManager.create(project: newProject)
    }
    
    private func createProjectEntities(newProjectEntity: ProjectEntity) {
        var projects = projectEntities.value
        
        projects.append(newProjectEntity)
        projectEntities.accept(projects)
    }
    
    private func createCoreDate(newProjectEntities: [ProjectEntity]) {
        let newProjects = newProjectEntities.compactMap {
            parse(from: $0)
        }
        
        persistentManager.create(projects: newProjects)
    }
    
    private func createProjectEntities(newProjectEntities: [ProjectEntity]) {
        projectEntities.accept(newProjectEntities)
    }
    
    private func updateCoreDate(newProjectEntity: ProjectEntity) {
        guard let newProject = parse(from: newProjectEntity) else {
            return
        }
        
        persistentManager.update(project: newProject)
    }
    
    private func updateProjectEntities(newProjectEntity: ProjectEntity) {
        let projects = projectEntities.value
        
        if let indexToUpdated = projects.firstIndex(where: { $0.id == newProjectEntity.id}) {
            var projectsToUpdate = projectEntities.value
            
            projectsToUpdate[indexToUpdated] = newProjectEntity
            projectEntities.accept(projectsToUpdate)
        }
    }
    
    private func deleteCoreDate(projectEntityID: UUID?) {
        persistentManager.delete(projectEntityID: projectEntityID)
    }
    
    private func deleteProjectEntities(projectEntityID: UUID?) {
        let projects = projectEntities.value
        
        if let indexToDelete = projects.firstIndex(where: { $0.id == projectEntityID}) {
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
