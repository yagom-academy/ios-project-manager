//
//  ProjectCoreData.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/23.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    private let containerName = "CoreData"
    private let entityName = "ProjectCoreModel"
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("unresolved Error \(error), \(error.userInfo)")
            }
        }
        
        return container
    }()
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func fetchContext(request: NSFetchRequest<ProjectCoreModel>) -> [ProjectCoreModel] {
        var projectCoreModels: [ProjectCoreModel] = []
        
        do {
            projectCoreModels = try context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        
        return projectCoreModels
    }
}

extension CoreDataManager: ProjectCRUDable {

    func create(_ data: ProjectViewModel) {
        let projectCoreModel = ProjectCoreModel(context: context)
        projectCoreModel.title = data.project.title
        projectCoreModel.detail = data.project.detail
        projectCoreModel.date = data.project.date
        projectCoreModel.uuid = data.project.uuid
        projectCoreModel.stateRawValue = data.state.rawValue
        
        saveContext()
    }
    
    func read(completion: @escaping (Result<[ProjectViewModel], Error>) -> Void) {
        let request = NSFetchRequest<ProjectCoreModel>(entityName: entityName)
        let projectCoreModels = fetchContext(request: request)
        let projectViewModels = projectCoreModels.map { projectCoreModel in
            ProjectViewModel(project: Project(title: projectCoreModel.title,
                                              detail: projectCoreModel.detail,
                                              date: projectCoreModel.date,
                                              uuid: projectCoreModel.uuid),
                             state: projectCoreModel.state)}
        
        completion(.success(projectViewModels))
    }
    
    func update(_ data: ProjectViewModel) {
        let request = NSFetchRequest<ProjectCoreModel>(entityName: entityName)
        request.predicate = .init(format: "uuid = %@", data.project.uuid.uuidString)
        
        guard let projectCoreModel = fetchContext(request: request).first else { return }
        projectCoreModel.title = data.project.title
        projectCoreModel.detail = data.project.detail
        projectCoreModel.date = data.project.date
        projectCoreModel.stateRawValue = data.state.rawValue
        
        saveContext()
    }
    
    func delete(_ data: ProjectViewModel) {
        let request = NSFetchRequest<ProjectCoreModel>(entityName: entityName)
        request.predicate = .init(format: "uuid = %@", data.project.uuid.uuidString)
        
        guard let projectCoreModel = fetchContext(request: request).first else { return }
        context.delete(projectCoreModel)
        
        saveContext()
    }
    
    func deleteAll() {
        let request = NSFetchRequest<ProjectCoreModel>(entityName: entityName)
        
        let projectCoreModels = fetchContext(request: request)
        projectCoreModels.forEach { projectCoreModel in
            context.delete(projectCoreModel)
        }
        
        saveContext()
    }
}
