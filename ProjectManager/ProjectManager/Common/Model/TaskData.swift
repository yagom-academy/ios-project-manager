//
//  TaskData.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/13.
//

import Foundation

class TaskData {
    static let shared = TaskData()

    var databaseManager: DatabaseManager = RealmDatabaseManager()

    private init() {}
}
