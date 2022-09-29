//
//  MainHomeViewModel.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/13.
//
import Foundation

class MainHomeViewModel {
    var change: () -> Void = {}

    var todoCount: Int = 0 {
        didSet {
            self.change()
        }
    }

    var doingCount: Int = 0 {
        didSet {
            self.change()
        }
    }

    var doneCount: Int = 0 {
        didSet {
            self.change()
        }
    }

    let remoteManager = RemoteRealm()
    private let databaseManager = DatabaseManagerRealm()
    private var todoList = [TaskModel]()
    private var doingList = [TaskModel]()
    private var doneList = [TaskModel]()

    func move(_ index: Int, from nowState: TaskState, to nextState: TaskState) {
        var currentList = getCurrentList(state: nowState)
        var data = currentList[index]
        data.taskState = nextState.name
        currentList.remove(at: index)

        currentList = getCurrentList(state: nextState)
        currentList.append(data)
        databaseManager.update(data: data)
        remoteManager.databaseManager?.update(data: data)
    }

    func getDataList(of state: TaskState) -> [TaskModel] {
        let currentList = getCurrentList(state: state)
        return currentList
    }

    func fetchDataList() {
        let allData = databaseManager.read()

        todoList = allData.filter {
            $0.taskState == TaskState.todo.name
        }

        doingList = allData.filter {
            $0.taskState == TaskState.doing.name
        }

        doneList = allData.filter {
            $0.taskState == TaskState.done.name
        }

        todoCount = todoList.count
        doingCount = doingList.count
        doneCount = doneList.count
    }

    func remove(index: Int, in state: TaskState) {
        var currentList = getCurrentList(state: state)
        let data = currentList[index]
        currentList.remove(at: index)
        databaseManager.delete(data: data)
        remoteManager.databaseManager?.delete(data: data)
        fetchDataList()
    }

    func changeList(data: TaskModel) -> Activity? {
        guard databaseManager.search(data: data) != nil else {
            databaseManager.create(data: data)
            remoteManager.databaseManager?.create(data: data)
            fetchDataList()
            return Activity.added
        }

        databaseManager.update(data: data)
        remoteManager.databaseManager?.update(data: data)
        fetchDataList()
        return nil
    }

    func synchronize() {
        remoteManager.initialize()
    }

    private func getCurrentList(state: TaskState) -> [TaskModel] {
        switch state {
        case .todo:
            return todoList
        case .doing:
            return doingList
        default:
            return doneList
        }
    }
}
