//
//  TaskDataManager.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/13.
//

import Foundation

class TaskDataManager {
    static let shared = TaskDataManager()

    var databaseManager: DatabaseProtocol = RealmDatabase()

    private init() { }
}
