//  ProjectManager - ToDoListViewModel.swift
//  created by zhilly on 2023/01/18

import Foundation

final class ToDoListViewModel {
    
    let todoModel: Observable<[ToDo]> = Observable([])
    let doingModel: Observable<[ToDo]> = Observable([])
    let doneModel: Observable<[ToDo]> = Observable([])
    
    private let todoCoreDataManager = ToDoManager.shared
    
    func addToDo(item: ToDo) {
        todoModel.value.append(item)
        
        do {
            try todoCoreDataManager.add(item)
        } catch {
            print("CoreData Add Error!")
        }
        
        NotificationCenter.default.post(name: Notification.Name.added,
                                        object: nil,
                                        userInfo: ["Title": item.title])
    }
    
    func fetchToDo(index: Int, state: ToDoState) -> ToDo? {
        switch state {
        case .toDo:
            return todoModel.value[index]
        case .doing:
            return doingModel.value[index]
        case .done:
            return doneModel.value[index]
        }
    }
    
    func fetchList(state: ToDoState) -> [ToDo] {
        switch state {
        case .toDo:
            return todoModel.value
        case .doing:
            return doingModel.value
        case .done:
            return doneModel.value
        }
    }
    
    func update(currentState: ToDoState,
                indexPath: Int,
                title: String,
                body: String,
                deadline: Date) {
        var data: ToDo
        var model: Observable<[ToDo]>
        
        switch currentState {
        case .toDo:
            data = todoModel.value[indexPath]
            model = self.todoModel
        case .doing:
            data = doingModel.value[indexPath]
            model = self.doingModel
        case .done:
            data = doneModel.value[indexPath]
            model = self.doneModel
        }
        
        data.title = title
        data.body = body
        data.deadline = deadline
        model.value[indexPath] = data
    }
    
    func updateStatus(indexPath: Int, currentState: ToDoState, changeState: ToDoState) {
        var data: ToDo
        var model: Observable<[ToDo]>
        
        switch currentState {
        case .toDo:
            data = todoModel.value.remove(at: indexPath)
        case .doing:
            data = doingModel.value.remove(at: indexPath)
        case .done:
            data = doneModel.value.remove(at: indexPath)
        }
        
        switch changeState {
        case .toDo:
            model = self.todoModel
        case .doing:
            model = self.doingModel
        case .done:
            model = self.doneModel
        }
        
        data.state = changeState
        model.value.append(data)
        
        NotificationCenter.default.post(name: Notification.Name.moved,
                                        object: nil,
                                        userInfo: [
                                            "Title": data.title,
                                            "PastState": currentState.description,
                                            "CurrentState": changeState.description
                                        ])
    }
    
    func delete(index: Int, state: ToDoState) {
        let deletedItem: ToDo
        
        switch state {
        case .toDo:
            deletedItem = todoModel.value.remove(at: index)
        case .doing:
            deletedItem = doingModel.value.remove(at: index)
        case .done:
            deletedItem = doneModel.value.remove(at: index)
        }
        
        NotificationCenter.default.post(name: Notification.Name.deleted,
                                        object: nil,
                                        userInfo: [
                                            "Title": deletedItem.title,
                                            "State": state.description
                                        ])
    }
    
    func count(state: ToDoState) -> Int {
        switch state {
        case .toDo:
            return todoModel.value.count
        case .doing:
            return doingModel.value.count
        case .done:
            return doneModel.value.count
        }
    }
}
