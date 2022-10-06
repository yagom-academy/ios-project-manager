//
//  RealmDatabase.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/12.
//

import RealmSwift

class DatabaseManagerRealm: DatabaseProtocol {
    private var realm: Realm?

    init(realm: Realm? = try? Realm()) {
        self.realm = realm
    }

    func create(data: TaskModel) {
        let data = RealmDatabaseModel(
            id: data.id,
            title: data.taskTitle,
            description: data.taskDescription,
            deadline: data.taskDeadline,
            state: data.taskState
        )

        guard let realm = realm else {
            return
        }

        do {
            try realm.write({
                realm.add(data)
            })
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

    func read() -> [TaskModel] {
        guard let realm = realm else {
            return [TaskModel]()
        }

        let realmModels = Array(realm.objects(RealmDatabaseModel.self))
        let taskModels = realmModels.map { model in
            TaskModel(
                taskTitle: model.taskTitle,
                taskDescription: model.taskDescription,
                taskDeadline: model.taskDeadline,
                taskState: model.taskState,
                id: model._id
            )
        }

        return taskModels
    }

    func update(data: TaskModel) {
        guard let realm = realm,
              let searchData = search(data: data) as? RealmDatabaseModel else {
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
            print("Error: \(error.localizedDescription)")
        }
    }

    func delete(data: TaskModel) {
        guard let realm = realm,
              let searchData = search(data: data) as? RealmDatabaseModel else {
            return
        }

        do {
            try realm.write({
                realm.delete(searchData)
            })
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

    func deleteAll() {
        guard let realm = realm else {
            return
        }

        do {
            try realm.write({
                realm.deleteAll()
            })
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

    func search(data: TaskModel) -> AnyObject? {
        guard let realm = realm else {
            return nil
        }

        let realmData = realm.objects(RealmDatabaseModel.self).where {
            $0._id == data.id
        }.first

        return realmData
    }
}
