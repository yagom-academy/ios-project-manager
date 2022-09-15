//
//  RealmDatabase.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/12.
//

import RealmSwift

class RealmDatabase: DatabaseProtocol {
    let realm = try? Realm()

    func createDatabase(data: Object) {
        guard let realm = realm,
              ((try? realm.write({ realm.add(data) })) != nil) else {
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
            taskModel.taskState = realmDatabaseModel.taskState
            taskModel.id = realmDatabaseModel.id
            database.append(taskModel)
        }

        return database
    }

    func updateDatabase(data: TaskModel) {
        guard let realm = realm,
              let searchData = search(data: data) else {
            return
        }

        do {
            try realm.write({
                searchData.taskTitle = data.taskTitle
                searchData.taskDescription = data.taskDescription
                searchData.taskDeadline = data.taskDeadline
                searchData.taskState = data.taskState
            })
        } catch {
            print("업데이트 실패")
        }
    }

    func deleteDatabase(data: TaskModel) {
        guard let realm = realm,
              let searchData = search(data: data) else {
            return
        }

        do {
            try realm.write({
                realm.delete(searchData)
            })
        } catch {
            print("삭제 실패")
        }
    }

    func deleteAllDatabase() {
        guard let realm = realm,
              ((try? realm.write({ realm.deleteAll() })) != nil)
        else {
            return
        }
    }

    private func search(data: TaskModel) -> RealmDatabaseModel? {
        guard let realm = realm,
                let id = data.id else {
            return nil
        }

        let relamData = realm.objects(RealmDatabaseModel.self).where {
            $0.id == id
        }.first

        return relamData
    }
}
