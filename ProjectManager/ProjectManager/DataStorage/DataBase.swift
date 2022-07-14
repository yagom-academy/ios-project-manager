//
//  DataBase.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/12.
//

import Foundation

import RxRelay

protocol DataBase {
    var data: BehaviorRelay<[Todo]> { get set }
    func create(todoListData: [Todo])
    func read(identifier: UUID) -> Todo?
    func update(todo: Todo)
    func delete(identifier: UUID)
}

final class TempDataBase: DataBase {
    let tempTodoData = TempData().todoData
    let tempDoneData = TempData().doneData
    let tempDoingData = TempData().doingData
    
    var data = BehaviorRelay<[Todo]>(value: [])
        
    init() {
        self.data.accept(self.fetch())
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
    
    func create(todoListData: [Todo]) {
        self.data.accept(self.data.value + todoListData)
    }
    
    func read(identifier: UUID) -> Todo? {
        let item = self.data.value.filter { $0.identifier == identifier }
        return item.first
    }
    
    func update(todo: Todo) {
        let items = self.data.value.filter { $0.identifier != todo.identifier }
        self.data.accept(items + [todo])
    }
    
    func delete(identifier: UUID) {
        let item = self.read(identifier: identifier)
        let items = self.data.value.filter { $0.identifier != item?.identifier }
        self.data.accept(items)
    }
}
