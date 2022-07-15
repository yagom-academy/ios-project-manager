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
    
    func create(todoList: [Todo])
    func read(todoID: UUID) -> Todo?
    func update(selectedTodo: Todo)
    func delete(todoID: UUID)
}

final class TempDataBase: Database {
    let tempTodoData = TempData().todoData
    let tempDoneData = TempData().doneData
    let tempDoingData = TempData().doingData
    
    var todoListBehaviorRelay = BehaviorRelay<[Todo]>(value: [])
        
    init() {
        self.todoListBehaviorRelay.accept(self.fetch())
    }
    
    private func fetch() -> [Todo] {
        guard let tempTodoStatus = self.tempTodoData["todoListItemStatus"],
              let tempTodoTitle = self.tempTodoData["title"],
              let tempTodoDescription = self.tempTodoData["description"] else {
            return [Todo(todoListItemStatus: .todo, identifier: UUID(), title: "", description: "", date: Date())]
        }
        
        guard let tempDoneStatus = self.tempDoneData["todoListItemStatus"],
              let tempDoneTitle = self.tempDoneData["title"],
              let tempDoneDescription = self.tempDoneData["description"] else {
            return [Todo(todoListItemStatus: .done, identifier: UUID(), title: "", description: "", date: Date())]
        }
        
        guard let tempDoingStatus = self.tempDoingData["todoListItemStatus"],
              let tempDoingTitle = self.tempDoingData["title"],
              let tempDoingDescription = self.tempDoingData["description"] else {
            return [Todo(todoListItemStatus: .doing, identifier: UUID(), title: "", description: "", date: Date())]
        }
        
        let tempTodoData = [
            Todo(todoListItemStatus: TodoListItemStatus(rawValue: tempTodoStatus) ?? TodoListItemStatus.todo, identifier: UUID(), title: tempTodoTitle, description: tempTodoDescription, date: Date()),
            Todo(todoListItemStatus: TodoListItemStatus(rawValue: tempDoneStatus) ?? TodoListItemStatus.done, identifier: UUID(), title: tempDoneTitle, description: tempDoneDescription, date: Date()),
            Todo(todoListItemStatus: TodoListItemStatus(rawValue: tempDoingStatus) ?? TodoListItemStatus.doing, identifier: UUID(), title: tempDoingTitle, description: tempDoingDescription, date: Date())
        ]
        
        return tempTodoData
    }
    
    func create(todoList: [Todo]) {
        self.todoListBehaviorRelay.accept(self.todoListBehaviorRelay.value + todoList)
    }
    
    func read(todoID: UUID) -> Todo? {
        let item = self.todoListBehaviorRelay.value.filter { $0.identifier == todoID }
        return item.first
    }
    
    func update(selectedTodo: Todo) {
        let items = self.todoListBehaviorRelay.value.filter { $0.identifier != selectedTodo.identifier }
        self.todoListBehaviorRelay.accept([selectedTodo] + items)
    }
    
    func delete(todoID: UUID) {
        let items = self.todoListBehaviorRelay.value.filter { $0.identifier != todoID }
        self.todoListBehaviorRelay.accept(items)
    }
}
