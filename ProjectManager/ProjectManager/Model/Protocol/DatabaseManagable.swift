//
//  DatabaseManagable.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/30.
//

protocol DatabaseManagable {
    func createTask(_ task: Task)
    func fetchTasks(_ completion: @escaping (Result<[Task], Error>) -> Void)
    func deleteTask(_ task: Task)
    func updateTask(_ task: Task)
}
