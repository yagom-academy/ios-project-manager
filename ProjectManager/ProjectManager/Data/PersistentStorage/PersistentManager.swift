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

extension PersistentManager {
    func create(project: ProjectDTO) {
        saveToContext(project)
    }
    
    func read() -> [Project] {
        guard let projects = fetchProjects() else {
            return []
        }
        return projects
    }
    
    func read(id: UUID?) -> Project? {
        guard let project = fetchProject(id: id?.uuidString) else {
            return nil
        }
        return project
    }

    func update(project: ProjectDTO) {
        let oldProject = fetchProject(id: project.id.uuidString)
        
        oldProject?.setValue(project.title, forKey: "title")
        oldProject?.setValue(project.status, forKey: "status")
        oldProject?.setValue(project.deadline, forKey: "deadline")
        oldProject?.setValue(project.body, forKey: "body")
        
        guard let _ = try? context.save() else {
            return
        }
    }

    func delete(projectContentID: UUID?) {
        guard let projectToDelete = fetchProject(id: projectContentID?.uuidString) else {
            return
        }
        
        context.delete(projectToDelete)
        
        guard let _ = try? context.save() else {
            return
        }
    }
}

extension PersistentManager {
    private func saveToContext(_ project: ProjectDTO) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Project", in: context) else {
            return
        }
        
        let managedObject = NSManagedObject(entity: entity, insertInto: context)
        
        managedObject.setValue(project.id, forKey: "id")
        managedObject.setValue(project.title, forKey: "title")
        managedObject.setValue(project.status, forKey: "status")
        managedObject.setValue(project.deadline, forKey: "deadline")
        managedObject.setValue(project.body, forKey: "body")
        
        guard let _ = try? context.save() else {
            return
        }
    }

    private func fetchProjects() -> [Project]? {
        guard let fetchedProjects = try? context.fetch(makeRequest()) else {
            return nil
        }
        
        return fetchedProjects
    }
    
    private func fetchProject(id: String?) -> Project? {
        guard let fetchedProject = try? context.fetch(makeRequest(by: id)) else {
            return nil
        }
        
        return fetchedProject.first
    }
    
    private func makeRequest(by id: String? = nil) -> NSFetchRequest<Project> {
        let request: NSFetchRequest<Project> = Project.fetchRequest()
        
        if let id = id {
            let predicate = NSPredicate(format: "id == %@", id)
            request.predicate = predicate
        }
        
        return request
    }
}

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier ?? ""
    static let data = OSLog(subsystem: subsystem, category: "Data")
}
