//
//  TaskRemoteDataSource.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/15.
//

import Foundation

final class TaskRemoteDataSource: TaskRepositoryDataSource {
    
    private let databaseModel = FirebaseManager()
    
    var fetchAllRecords: [Task] {
        databaseModel
            .fetchAllRecords
            .map { remoteTask in
                Task(remoteTask)
            }
    }
    
    func fetch(_ condition: ((Task) -> Bool)) throws -> [Task] {
        fetchAllRecords.filter(condition)
    }
    
    func create(_ object: Task) throws {
        databaseModel.create(FirebaseTask(object))
    }
    
    func delete(_ object: Task) throws {
        databaseModel.remove(FirebaseTask(object))
    }
    
    func update(_ object: Task) throws {
        databaseModel.remove(FirebaseTask(object))
        databaseModel.create(FirebaseTask(object))
    }
    
    func removeAllRecords() throws {
        databaseModel.removeAll()
    }
    
}
