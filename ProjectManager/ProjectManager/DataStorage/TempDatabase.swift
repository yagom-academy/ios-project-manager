//
//  TempDataBase.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/12.
//

import Foundation

import RxRelay

protocol Database {
    var todoListBehaviorRelay: BehaviorRelay<[Todo]> { get set }
    
    func create(todoData: Todo)
    func read()
    func update(selectedTodo: Todo)
    func delete(todoID: UUID)
}

final class TempDatabase: Database {
    let tempTodoData = TempData().todoData
    let tempDoneData = TempData().doneData
    let tempDoingData = TempData().doingData
    
    var todoListBehaviorRelay = BehaviorRelay<[Todo]>(value: [])
    
    init() {
        self.read()
    }
    
    func create(todoData: Todo) {
        self.todoListBehaviorRelay.accept(self.todoListBehaviorRelay.value + [todoData])
    }
    
    func read() {
        guard let tempTodoStatus = self.tempTodoData["todoListItemStatus"],
              let tempTodoTitle = self.tempTodoData["title"],
              let tempTodoDescription = self.tempTodoData["description"] else {
            return
        }
        
        guard let tempDoneStatus = self.tempDoneData["todoListItemStatus"],
              let tempDoneTitle = self.tempDoneData["title"],
              let tempDoneDescription = self.tempDoneData["description"] else {
            return
        }
        
        guard let tempDoingStatus = self.tempDoingData["todoListItemStatus"],
              let tempDoingTitle = self.tempDoingData["title"],
              let tempDoingDescription = self.tempDoingData["description"] else {
            return
        }
        
        let tempTodoData = [
            Todo(todoListItemStatus: TodoListItemStatus(rawValue: tempTodoStatus) ?? TodoListItemStatus.todo, title: tempTodoTitle, description: tempTodoDescription),
            Todo(todoListItemStatus: TodoListItemStatus(rawValue: tempDoneStatus) ?? TodoListItemStatus.done, title: tempDoneTitle, description: tempDoneDescription),
            Todo(todoListItemStatus: TodoListItemStatus(rawValue: tempDoingStatus) ?? TodoListItemStatus.doing, title: tempDoingTitle, description: tempDoingDescription)
        ]
        
        self.todoListBehaviorRelay.accept(tempTodoData)
    }
    
    func update(selectedTodo: Todo) {
        var todoArray = self.todoListBehaviorRelay.value
        if let index = todoArray.firstIndex(where: { $0.identifier == selectedTodo.identifier }) {
            todoArray[index] = selectedTodo
        }
        
        self.todoListBehaviorRelay.accept(todoArray)
    }
    
    func delete(todoID: UUID) {
        let items = self.todoListBehaviorRelay.value.filter { $0.identifier != todoID }
        self.todoListBehaviorRelay.accept(items)
    }
}
