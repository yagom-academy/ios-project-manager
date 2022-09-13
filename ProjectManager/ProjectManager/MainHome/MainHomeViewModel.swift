//
//  MainHomeViewModel.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/13.
//

import Foundation

class MainHomeViewModel {

    var todoCount: Int {
        return taskDataStore.todoList.count
    }
    var doingCount: Int {
        return taskDataStore.doingList.count
    }
    var doneCount: Int {
        return taskDataStore.doneList.count
    }
    var currentState: String = TaskState.todo

    private var currentList: [TaskModel] {
        get {
            switch currentState {
            case TaskState.todo:
                return taskDataStore.todoList
            case TaskState.doing:
                return taskDataStore.doingList
            default:
                return taskDataStore.doneList
            }
        }
        set { }
    }
    private var taskDataStore = TaskDataStore()
    private let databaseManager: DatabaseManager = RealmDatabaseManager()

    func move(to state: String, _ index: Int) {
        var data = currentList[index]
        data.taskState = TaskState.doing
        currentList.remove(at: index)

        currentState = state

        currentList.append(data)
        databaseManager.updateDatabase(data: data, id: data.id ?? UUID())
    }
}
