//
//  LocalDataBaseManager.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/07.
//

import CoreData
import SwiftUI

final class LocalDataBaseManager: DataBaseLogic {
    lazy private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Diary")
        container.loadPersistentStores(completionHandler: { (_, _) in
        })
        return container
    }()
    
    func create(data: ProjectUnit) throws {
        let context = persistentContainer.viewContext
        let project = Project(context: context)
        
        project.setValue(data.title, forKey: "title")
        project.setValue(data.body, forKey: "body")
        project.setValue(data.deadLine, forKey: "deadLine")
        project.setValue(data.section, forKey: "section")
        project.setValue(data.id, forKey: "id")
        
        if context.hasChanges {
            try context.save()
        }
    }
    
    func fetchSection(_ section: String) throws -> [ProjectUnit] {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<Project>(entityName: "Project")
        request.predicate = NSPredicate(format: "section = %@", section)
        
        let projects = try context.fetch(request)
        let result = projects.compactMap { data -> ProjectUnit? in
            guard let title = data.title,
                  let body = data.body,
                  let deadLine = data.deadLine,
                  let section = data.section,
                  let id = data.id else {
                return nil
            }
            
            return ProjectUnit(
                id: id,
                title: title,
                body: body,
                section: section,
                deadLine: deadLine
            )
        }
        
        return result
    }
    
    func update(data: ProjectUnit) throws {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<Project>(entityName: "Project")
        request.predicate = NSPredicate(format: "id = %@", data.id as CVarArg)
        
        guard let project = try context.fetch(request).first else {
            throw DataBaseError.invalidFetchRequest
        }
        
        project.body = data.body
        project.title = data.title
        project.deadLine = data.deadLine
        project.section = data.section
        
        if context.hasChanges {
            try context.save()
        }
    }
    func delete(id: UUID) throws {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<Project>(entityName: "Project")
        request.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        
        guard let project = try context.fetch(request).first else {
            throw DataBaseError.invalidFetchRequest
        }
        
        context.delete(project)
        
        if context.hasChanges {
            try context.save()
        }
    }
}
