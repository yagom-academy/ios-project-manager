//
//  ProjectLocalDataBase.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/17.
//

import CoreData
import UIKit

class ProjectCoreDataBase {
    
    typealias Item = Project
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Project")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print(error.localizedDescription)
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    func read(of status: Status) -> [Project]? {
        let results = self.fetch(of: status)
        let projects = results?.compactMap({ project in
            return Project(identifier: project.identifier ,
                    title: project.title,
                    deadline: project.deadline,
                    description: project.descriptions,
                    status: project.status)
        })
        return projects
    }
    
    func update<T>(
        of identifier: T,
        with status: Status
    ) where T : Hashable & CustomStringConvertible {
        let project = self.fetch(of: identifier)
        
        project?.status = status
        self.save()
    }
    
    private func fetch<T>(of identifier: T) -> CDProject? {
        let fetchRequest = CDProject.fetchRequest()
        let identifierString = String(describing: identifier)
        let predicate = NSPredicate(format: "identifier = %@", identifierString)
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
        let sortDescriptor = NSSortDescriptor(key: "deadline", ascending: true)
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

extension ProjectCoreDataBase: LocalDataBase {
    
    func create(with content: [String : Any]) {
        let project = CDProject(context: context)
        project.identifier = content["identifier"] as? String
        project.title = content["title"] as? String
        project.descriptions = content["description"] as? String
        project.deadline = content["deadline"] as? Date
        project.status = content["status"] as? Status
        
        self.save()
    }
    
    func read<T>(of identifier: T) -> Project? where T : CustomStringConvertible, T : Hashable {
        let result = self.fetch(of: identifier)
        let project = Project(identifier: result?.identifier,
                              title: result?.title,
                              deadline: result?.deadline,
                              description: result?.descriptions,
                              status: result?.status)
        return project
    }
    
    func update<T>(of identifier: T,
                   with content: [String : Any]
    ) where T : CustomStringConvertible, T : Hashable {
        let project = self.fetch(of: identifier)
        project?.title = content["title"] as? String
        project?.descriptions = content["description"] as? String
        project?.deadline = content["deadline"] as? Date
        project?.status = content["status"] as? Status
        
        self.save()
    }
    
    func delete<T>(of identifier: T) where T : CustomStringConvertible, T : Hashable {
        guard let project = self.fetch(of: identifier) else {
            return
        }
        context.delete(project)
        self.save()
    }
}
