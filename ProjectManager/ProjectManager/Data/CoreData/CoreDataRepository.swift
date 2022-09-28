//
//  CoreDataRepository.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/28.
//

import Foundation
import CoreData

class CoreDataRepository: ProjectRepository {
    private var coreDataManager: CoreDataManager<ProjectModel>
    
    init() {
        self.coreDataManager = CoreDataManager<ProjectModel>(modelName: "ProjectCoreDataModel",
                                                             entityName: "Project")
    }
    
    func create(data: ProjectModel) {
        let dictionnary = [
            "id": data.id,
            "title": data.title,
            "body": data.body,
            "date": data.date,
            "workState": data.workState.rawValue
        ] as [String: Any]
        
        coreDataManager.createObject(entityKeyValue: dictionnary)
    }
    
    func read(completionHandler: @escaping ([ProjectModel]) -> Void) {
        switch coreDataManager.readObject(request: Project.fetchRequest()) {
        case .success(let fetchList):
            let list = fetchList.map {
                ProjectModel(id: $0.id ?? "",
                             title: $0.title ?? "",
                             body: $0.body ?? "",
                             date: $0.date ?? Date(),
                             workState: ProjectState(rawValue: $0.workState ?? "todo") ?? .todo)
            }
            
            completionHandler(list)
        case .failure(let error):
            print(error)
            completionHandler([])
        }
    }
    
    func update(id: String, data: ProjectModel) {
        switch coreDataManager.readObject(request: Project.fetchRequest()) {
        case .success(let fetchList):
            guard let filteredList = fetchList.filter({ $0.id == id }).first
            else { return }
            
            let dictionnary = [
                "id": data.id,
                "title": data.title,
                "body": data.body,
                "date": data.date,
                "workState": data.workState.rawValue
            ] as [String: Any]
            
            coreDataManager.updateObject(object: filteredList, entityKeyValue: dictionnary)
        case .failure(let error):
            print(error)
        }
    }
    
    func delete(id: String) {
        switch coreDataManager.readObject(request: Project.fetchRequest()) {
        case .success(let fetchList):
            guard let object = fetchList.filter({ $0.id == id }).first
            else { return }
            
            coreDataManager.deleteObject(object: object)
        case .failure(let error):
            print(error)
        }
    }
}
