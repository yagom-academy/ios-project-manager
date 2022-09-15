//
//  MainHomeViewModel.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/13.
//

import Foundation

class MainHomeViewModel {
    var todoCount: Int {
        return todoList.count
    }
    var doingCount: Int {
        return doingList.count
    }
    var doneCount: Int {
        return doneList.count
    }
    var currentState: String = TaskState.todo

    private var todoList = [TaskModel]()
    private var doingList = [TaskModel]()
    private var doneList = [TaskModel]()
    private var currentList: [TaskModel] {
        get {
            switch currentState {
            case TaskState.todo:
                return todoList
            case TaskState.doing:
                return doingList
            default:
                return doneList
            }
        }
        set {
            switch currentState {
            case TaskState.todo:
                todoList = newValue
                return
            case TaskState.doing:
                doingList = newValue
                return
            default:
                doneList = newValue
                return
            }
        }
    }

    func move(to state: String, _ index: Int) {
        var data = currentList[index]
        data.taskState = state
        currentList.remove(at: index)

        currentState = state

        currentList.append(data)
        TaskDataManager.shared.databaseManager.updateDatabase(data: data)
    }

    func readData(index: Int) -> TaskModel {
        return currentList[index]
    }

    func getDataList() -> [TaskModel] {
        return currentList
    }

    func fetchDataList() {
        let allData = TaskDataManager.shared.databaseManager.readDatabase()
        todoList = [TaskModel]()
        doingList = [TaskModel]()
        doneList = [TaskModel]()

        allData.forEach { data in
            currentState = data.taskState
            currentList.append(data)
        }
    }

    func remove(index: Int) {
        let data = currentList[index]
        currentList.remove(at: index)
        TaskDataManager.shared.databaseManager.deleteDatabase(data: data)
    }
}
