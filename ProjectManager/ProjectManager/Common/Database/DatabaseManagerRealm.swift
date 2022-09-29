//
//  RealmDatabase.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/12.
//

import RealmSwift

class DatabaseManagerRealm: DatabaseProtocol {
    var realm: Realm?

    init(realm: Realm? = try? Realm()) {
        self.realm = realm
    }

    func create(data: TaskModel) {
        let data = RealmDatabaseModel(
            title: data.taskTitle,
            description: data.taskDescription,
            deadline: data.taskDeadline,
            state: data.taskState
        )

        guard let realm = realm else {
            print("❌ create 메서드 realm 가져오기 실패")
            return
        }

        do {
            try realm.write({
                realm.add(data)
            })
        } catch {
            print("추가 실패")
        }
    }

    func read() -> [TaskModel] {
        guard let realm = realm else {
            print("❌ read 메서드 realm 가져오기 실패")
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
            print("❌ update 메서드 realm 가져오기 실패")
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

    func delete(data: TaskModel) {
        guard let realm = realm,
              let searchData = search(data: data) as? RealmDatabaseModel else {
            print("❌ delete 메서드 realm 가져오기 실패")
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

    func deleteAll() {
        guard let realm = realm else {
            print("❌ deleteAll 메서드 realm 가져오기 실패")
            return
        }

        do {
            try realm.write({
                realm.deleteAll()
            })
        } catch {
            print("전체 삭제 실패")
        }
    }

    func search(data: TaskModel) -> AnyObject? {
        guard let realm = realm,
              let id = data.id else {
            print("❌ search 메서드 realm 가져오기 실패")
            return nil
        }

        let realmData = realm.objects(RealmDatabaseModel.self).where {
            $0._id == id
        }.first

        return realmData
    }
}
