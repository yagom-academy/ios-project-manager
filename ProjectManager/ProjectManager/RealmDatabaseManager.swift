//
//  RealmDatabaseManager.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/12.
//

import RealmSwift

class RealmDatabaseManager: DatabaseManager {

    let realm = try? Realm()

    func createDatabase(data: Object) {
        guard let realm = realm,
              ((try? realm.write({ realm.add(data) })) != nil)
        else {
            return
        }
    }

    func readDatabase() -> [TaskModel] {
        guard let realm = realm else {
            return [TaskModel]()
        }

        var database = [TaskModel]()
        let realmDatabase = realm.objects(RealmDatabaseModel.self)

        realmDatabase.forEach { realmDatabaseModel in
            var taskModel = TaskModel()
            taskModel.taskTitle = realmDatabaseModel.taskTitle
            taskModel.taskDescription = realmDatabaseModel.taskDescription
            taskModel.taskDeadline = realmDatabaseModel.taskDeadline
            database.append(taskModel)
        }

        return database
    }

    func updateDatabase() { }

    func deleteDatabase() {
        guard let realm = realm,
              ((try? realm.write({ realm.deleteAll() })) != nil)
        else {
            return
        }
    }
}
