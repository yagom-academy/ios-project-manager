//
//  ToDoUseCase.swift
//  ProjectManager
//
//  Created by Max on 2023/10/06.
//

import CoreData

struct ToDoUseCase {
    private let coreDataManager: CoreDataManager
    
    init(dataManager: CoreDataManager) {
        coreDataManager = dataManager
    }

    func fetchDataByStatus(for status: ToDoStatus) throws -> [ToDo] {
        let predicated = NSPredicate(format: "status == %@", status.rawValue)
        let filtered = try coreDataManager.fetchData(entityName:"ToDo", predicate: predicated, sort: "modifiedAt")
        
        guard let result = filtered as? [ToDo] else {
            throw CoreDataError.unknown
        }
        return result
    }
    
    func createData(values: [KeywordArgument]) throws {
        var values = values
        
        if values.filter({ $0.key == "id" }).isEmpty {
            values.append(KeywordArgument(key: "id", value: UUID()))
        }
        
        if values.filter({ $0.key == "modifiedAt" }).isEmpty {
            values.append(KeywordArgument(key: "modifiedAt", value: Date()))
        }
        
        if values.filter({ $0.key == "status" }).isEmpty {
            values.append(KeywordArgument(key: "status", value: ToDoStatus.toDo.rawValue))
        }
        try coreDataManager.createData(type: ToDo.self, values: values)
    }
    
    func updateData(_ entity: ToDo, values: [KeywordArgument]) throws {
        try coreDataManager.updateData(entity: entity, values: values)
    }
    
    func deleteData(_ entity: ToDo) throws {
        try coreDataManager.deleteData(entity: entity)
    }
}
