//
//  TaskLocalDataSource.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/15.
//

import Foundation

final class TaskLocalDataSource: TaskRepositoryDataSource {
    
    private let databaseModel = RealmManager<RealmTask>()
    
    var fetchAllRecords: [Task] {
        (try? databaseModel.fetch().map { Task($0) }) ?? []
    }
    
    func fetch(_ condition: ((Task) -> Bool)) throws -> [Task] {
        try databaseModel
            .fetch { condition(Task($0)) }
            .map { Task($0) }
    }
    
    func create(_ object: Task) throws {
        try databaseModel.create(RealmTask(object))
    }
    
    func delete(_ object: Task) throws {
        let target = try databaseModel.fetch { task in
            task.id == object.id
        }
        try databaseModel.remove(target)
    }
    
    func update(_ object: Task) throws {
        try databaseModel.update(RealmTask(object))
    }
    
    func removeAllRecords() throws {
        try databaseModel.removeAll()
    }
    
}
