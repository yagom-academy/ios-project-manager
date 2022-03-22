//
//  TaskRepositoryManager.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/15.
//

import Foundation

struct TaskRepositoryManager: TaskManager {
    
    private let localRepository = TaskLocalDataSource()
    private let remoteRepository = TaskRemoteDataSource()
    
    var todoTasks: [Task] {
        (try? localRepository.fetch { $0.status == .todo }) ?? []
    }
    
    var doingTasks: [Task] {
        (try? localRepository.fetch { $0.status == .doing }) ?? []
    }
    
    var doneTasks: [Task] {
        (try? localRepository.fetch { $0.status == .done }) ?? []
    }
    
    mutating func create(_ task: Task) throws {
        try localRepository.create(task)
    }
    
    mutating func delete(_ task: Task) throws {
        try localRepository.delete(task)
    }
    
    mutating func update(_ oldTask: Task, to newTask: Task) throws {
        try localRepository.update(newTask)
    }
    
    func sync() throws {
        print("Hello World")
        try remoteRepository.removeAllRecords()
        for record in localRepository.fetchAllRecords {
            try remoteRepository.create(record)
        }
    }
    
}
