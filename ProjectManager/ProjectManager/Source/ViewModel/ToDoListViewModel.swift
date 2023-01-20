//  ProjectManager - ToDoListViewModel.swift
//  created by zhilly on 2023/01/18

import Foundation

final class ToDoListViewModel {
    
    let todoModel: Observable<[ToDo]> = Observable([])
    let doingModel: Observable<[ToDo]> = Observable([])
    let doneModel: Observable<[ToDo]> = Observable([])
    
    func addToDo(item: ToDo) {
        todoModel.value.append(item)
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
    }
    
    func delete(indexPath: Int, state: ToDoState) {
        switch state {
        case .toDo:
            todoModel.value.remove(at: indexPath)
        case .doing:
            doingModel.value.remove(at: indexPath)
        case .done:
            doneModel.value.remove(at: indexPath)
        }
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
