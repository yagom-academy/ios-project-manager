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
        T
        let result = try await databaseModel.fetch()
        let
    }
    
    func fetch(_ condition: ((Task) -> Bool)) throws -> [Task] {
        print(#function)
        return []
    }
    
    func create(_ object: Task) throws {
        print(#function)
    }
    
    func delete(_ object: Task) throws {
        print(#function)
    }
    
    func update(_ object: Task) throws {
        print(#function)
    }
    
    func removeAllRecords() throws {
        print(#function)
    }
    
}
