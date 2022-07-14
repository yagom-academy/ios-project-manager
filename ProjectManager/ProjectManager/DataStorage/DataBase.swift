//
//  DataBase.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/12.
//

import Foundation

import RxRelay

protocol DataBase {
    func save(todoListData: [Todo])
    var data: BehaviorRelay<[Todo]> { get set }
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
            return [Todo(todoListItemStatus: .todo, title: "", description: "", date: Date())]
        }
        
        guard let tempDoneStatus = self.tempDoneData["todoListItemStatus"],
              let tempDoneTitle = self.tempDoneData["title"],
              let tempDoneDescription = self.tempDoneData["description"] else {
            return [Todo(todoListItemStatus: .done, title: "", description: "", date: Date())]
        }
        
        guard let tempDoingStatus = self.tempDoingData["todoListItemStatus"],
              let tempDoingTitle = self.tempDoingData["title"],
              let tempDoingDescription = self.tempDoingData["description"] else {
            return [Todo(todoListItemStatus: .doing, title: "", description: "", date: Date())]
        }
        
        let tempTodoData = [
            Todo(todoListItemStatus: TodoListItemStatus(rawValue: tempTodoStatus) ?? TodoListItemStatus.todo, title: tempTodoTitle, description: tempTodoDescription, date: Date()),
            Todo(todoListItemStatus: TodoListItemStatus(rawValue: tempDoneStatus) ?? TodoListItemStatus.done, title: tempDoneTitle, description: tempDoneDescription, date: Date()),
            Todo(todoListItemStatus: TodoListItemStatus(rawValue: tempDoingStatus) ?? TodoListItemStatus.doing, title: tempDoingTitle, description: tempDoingDescription, date: Date())
        ]
        
        return tempTodoData
    }
    
    func save(todoListData: [Todo]) {
        self.data.accept(self.data.value + todoListData)
    }
}
