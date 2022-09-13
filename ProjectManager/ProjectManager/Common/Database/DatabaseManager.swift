//
//  DatabaseManager.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/12.
//

import RealmSwift

protocol DatabaseManager {
    func createDatabase(data: Object)
    func readDatabase() -> [TaskModel]
    func updateDatabase(data: TaskModel)
    func deleteDatabase(data: TaskModel)
}
