//
//  DatabaseManager.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/12.
//

import RealmSwift

protocol DatabaseProtocol {
    func create(data: TaskModel)
    func read() -> [TaskModel]
    func update(data: TaskModel)
    func delete(data: TaskModel)
    func deleteAll()
}
