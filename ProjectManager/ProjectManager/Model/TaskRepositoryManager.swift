//
//  TaskRepositoryManager.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/15.
//

import Foundation

struct TaskRepositoryManager: TaskManager {
    
    let localRepository = TaskLocalDataSource<Task>()
    let remoteRepository = TaskRemoteDataSource<Task>()
    
    var todoTasks: [Task] {
        localRepository.
    }
    
    var doingTasks: [Task] {
        []
    }
    
    var doneTasks: [Task] {
        []
    }
    
    mutating func create(_ task: Task) throws {
        print(#function)
    }
    
    mutating func delete(_ task: Task) throws {
        print(#function)
    }
    
    mutating func update(_ oldTask: Task, to newTask: Task) throws {
        print(#function)
    }
    
    func sync() {
        try? remoteRepository.removeAllRecords()
        for record in localRepository.fetchAllRecords {
            try? remoteRepository.create(record)
        }
    }
    
}
