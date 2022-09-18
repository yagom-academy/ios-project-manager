//
//  MainHomeViewModel.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/13.
//

class MainHomeViewModel {
    var todoCount: Observable<Int> = Observable(0)
    var doingCount: Observable<Int> = Observable(0)
    var doneCount: Observable<Int> = Observable(0)
    var currentState: String = TaskState.todo.name

    private let databaseManager = RealmDatabase()
    private var todoList = [TaskModel]()
    private var doingList = [TaskModel]()
    private var doneList = [TaskModel]()
    private var currentList: [TaskModel] {
        get {
            switch currentState {
            case TaskState.todo.name:
                return todoList
            case TaskState.doing.name:
                return doingList
            default:
                return doneList
            }
        }
        set {
            switch currentState {
            case TaskState.todo.name:
                todoList = newValue
                return
            case TaskState.doing.name:
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
        databaseManager.update(data: data)
    }

    func readData(index: Int) -> TaskModel {
        return currentList[index]
    }

    func getDataList() -> [TaskModel] {
        return currentList
    }

    func fetchDataList() {
        let allData = databaseManager.read()
        todoList = [TaskModel]()
        doingList = [TaskModel]()
        doneList = [TaskModel]()

        allData.forEach { data in
            currentState = data.taskState
            currentList.append(data)
        }

        todoCount.value = todoList.count
        doingCount.value = doingList.count
        doneCount.value = doneList.count
    }

    func remove(index: Int) {
        let data = currentList[index]
        currentList.remove(at: index)
        databaseManager.delete(data: data)
        fetchDataList()
    }

    func changeList(data: TaskModel) {
        guard databaseManager.search(data: data) != nil else {
             return databaseManager.create(data: data)
        }

        databaseManager.update(data: data)
        fetchDataList()
    }
}
