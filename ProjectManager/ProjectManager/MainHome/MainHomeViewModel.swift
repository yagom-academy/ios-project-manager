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
        set {
            switch currentState {
            case TaskState.todo:
                taskDataStore.todoList = newValue
                return
            case TaskState.doing:
                taskDataStore.doingList = newValue
                return
            default:
                taskDataStore.doneList = newValue
                return
            }
        }
    }
    private var taskDataStore = TaskDataStore()
    private let databaseManager: DatabaseManager = RealmDatabaseManager()

    func move(to state: String, _ index: Int) {
        var data = currentList[index]
        data.taskState = state
        currentList.remove(at: index)

        currentState = state

        currentList.append(data)
        databaseManager.updateDatabase(data: data)
    }

    func getDataList() -> [TaskModel] {
        return currentList
    }

    func fetchDataList() {
        let allData = databaseManager.readDatabase()

        allData.forEach { data in
            currentState = data.taskState
            currentList.append(data)
        }
    }

    func addTodo() {
        let allData = databaseManager.readDatabase()

        guard let data = allData.last else {
            return
        }

        taskDataStore.todoList.append(data)
    }

    func remove(index: Int) {
        let data = currentList[index]
        currentList.remove(at: index)
        databaseManager.deleteDatabase(data: data)
    }
}
