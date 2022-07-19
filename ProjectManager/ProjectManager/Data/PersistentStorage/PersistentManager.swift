//
//  PersistentManager.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/19.
//

import RxSwift
import RxRelay
import CoreData
import OSLog

final class PersistentManager {
    static let shared = PersistentManager()
    
    private init() { }
    
    private let projectEntities = BehaviorRelay<[ProjectContent]>(value: [])
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Project")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                os_log(.error, log: .data, "%@", "loadPersistentStores Error Occured.")
            }
        }
        return container
    }()
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}

extension PersistentManager: Storagable {
    func create(projectContent: ProjectContent) {
        guard let _ = try? saveToContext(projectContent) else {
            return
        }
        var currentProject = read().value
        currentProject.append(projectContent)
        projectEntities.accept(currentProject)
    }
    
    func read() -> BehaviorRelay<[ProjectContent]> {
        return projectEntities
    }
    
    func read(id: UUID?) -> ProjectContent? {
        return projectEntities.value.filter { $0.id == id }.first
    }
    
    func update(projectContent: ProjectContent) {
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
    
    private func saveToContext(_ projectContent: ProjectContent) throws {
        guard let entity = NSEntityDescription.entity(forEntityName: "Project", in: context) else {
            return
        }
        let managedObject = NSManagedObject(entity: entity, insertInto: context)
        try context.save()
    }
}

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier ?? ""
    static let data = OSLog(subsystem: subsystem, category: "Data")
}
