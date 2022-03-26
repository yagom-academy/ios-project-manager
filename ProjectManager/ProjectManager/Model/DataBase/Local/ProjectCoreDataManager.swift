//
//  ProjectCoreDataManager.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/17.
//

import CoreData
import UIKit

final class ProjectCoreDataManager {
    
    // MARK: - Property
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Project")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print(error.localizedDescription)
            }
        })
        return container
    }()
    
    private lazy var context = persistentContainer.viewContext
    
    // MARK: - Method
    private func fetch<T>(of identifier: T) -> CDProject? {
        let fetchRequest = CDProject.fetchRequest()
        let identifierString = String(describing: identifier)
        let predicate = NSPredicate(format: "\(ProjectKey.identifier.rawValue) = %@", identifierString)
        fetchRequest.predicate = predicate
        
        do {
            return try context.fetch(fetchRequest).first
        } catch  {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func fetch(of status: Status) -> [CDProject]? {
        let fetchRequest = CDProject.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: ProjectKey.deadline.rawValue, ascending: true)
        let predicate = NSPredicate(format: "statusString = %@", status.rawValue)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = predicate
        
        do {
            return try context.fetch(fetchRequest)
        } catch  {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - DataSource
extension ProjectCoreDataManager: DataSource {
    
    var type: DataSourceType {
        get {
            return .coreData
        }
    }
    
    func create(with content: [String : Any]) {
        let project = CDProject(context: context)
        project.identifier = content[ProjectKey.identifier.rawValue] as? String
        project.title = content[ProjectKey.title.rawValue] as? String
        project.descriptions = content[ProjectKey.description.rawValue] as? String
        project.deadline = content[ProjectKey.deadline.rawValue] as? Date
        project.status = content[ProjectKey.status.rawValue] as? Status
        
        self.save()
    }
    
    func read(of identifier: String, completion: @escaping (Result<Project?, Error>) -> Void) {
        let result = self.fetch(of: identifier)
        let project = Project(identifier: result?.identifier,
                              title: result?.title,
                              deadline: result?.deadline,
                              description: result?.descriptions,
                              status: result?.status)
        completion(.success(project))
    }
    
    func read(of group: Status, completion: @escaping (Result<[Project]?, Error>) -> Void) {
        let results = self.fetch(of: group)
        let projects = results?.compactMap({ project in
            return Project(identifier: project.identifier ,
                           title: project.title,
                           deadline: project.deadline,
                           description: project.descriptions,
                           status: project.status)
        })
        completion(.success(projects))
    }
    
    func updateContent(of identifier: String, with content: [String: Any]) {
        let project = self.fetch(of: identifier)
        project?.title = content[ProjectKey.title.rawValue] as? String
        project?.descriptions = content[ProjectKey.description.rawValue] as? String
        project?.deadline = content[ProjectKey.deadline.rawValue] as? Date
        project?.status = content[ProjectKey.status.rawValue] as? Status
        
        self.save()
    }
    
    func updateStatus(of identifier: String, with status: Status) {
        let project = self.fetch(of: identifier)
        
        project?.status = status
        self.save()
    }
    
    func delete(of identifier: String) {
        guard let project = self.fetch(of: identifier) else {
            return
        }
        context.delete(project)
        self.save()
    }
}
