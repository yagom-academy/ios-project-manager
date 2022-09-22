//
//  RealmDatabase.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/12.
//

import RealmSwift

class RealmDatabase: DatabaseProtocol {
    let realm = try? Realm()

    func create(data: TaskModel) {
        let data = RealmDatabaseModel(
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
            print("추가 실패")
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
                id: model.id
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
            print("업데이트 실패")
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
            print("삭제 실패")
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
            print("전체 삭제 실패")
        }
    }

    func search(data: TaskModel) -> AnyObject? {
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
