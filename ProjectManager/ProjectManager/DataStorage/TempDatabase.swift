//
//  TempDataBase.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/12.
//

import Foundation

import RxRelay

final class TempDatabase {
    let tempTodoData = TempData().todoData
    let tempDoneData = TempData().doneData
    let tempDoingData = TempData().doingData
    
    var tempArray: [Todo] = []
        
    init() {
        self.read()
    }
    
    func create(todoData: Todo) {
        self.tempArray.append(todoData)
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
        
        self.tempArray = [
            Todo(todoListItemStatus: TodoListItemStatus(rawValue: tempTodoStatus) ?? TodoListItemStatus.todo, title: tempTodoTitle, description: tempTodoDescription),
            Todo(todoListItemStatus: TodoListItemStatus(rawValue: tempDoneStatus) ?? TodoListItemStatus.done, title: tempDoneTitle, description: tempDoneDescription),
            Todo(todoListItemStatus: TodoListItemStatus(rawValue: tempDoingStatus) ?? TodoListItemStatus.doing, title: tempDoingTitle, description: tempDoingDescription)
        ]
}
    func update(selectedTodo: Todo) {
        if let index = self.tempArray.firstIndex(where: { $0.identifier == selectedTodo.identifier }) {
            tempArray[index] = selectedTodo
        }
}
    
    func delete(todoID: UUID) {
        let items = self.tempArray.filter { $0.identifier != todoID }
        self.tempArray = items
    }
}
