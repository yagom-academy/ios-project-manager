//
//  DBManager.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/30.
//

import Foundation

final class DBManager: DatabaseManagable {
    private var database: DatabaseManagable?
    
    func createTask(_ task: Task) {
        database?.createTask(task)
    }
    
    func fetchTasks(_ completion: @escaping (Result<[Task], Error>) -> Void) {
        database?.fetchTasks(completion)
    }
    
    func deleteTask(_ task: Task) {
        database?.deleteTask(task)
    }
    
    func updateTask(_ task: Task) {
        database?.updateTask(task)
    }
}
