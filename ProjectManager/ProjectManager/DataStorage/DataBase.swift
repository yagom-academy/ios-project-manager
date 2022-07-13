//
//  DataBase.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/12.
//

import Foundation
import TodoListViewModel_Fixture

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
            let tempTodoStatus = self.tempTodoData["todoListItemStatus"]
            let tempTodoTitle = self.tempTodoData["title"]
            let tempTodoDescription = self.tempTodoData["description"]

            let tempDoneStatus = self.tempDoneData["todoListItemStatus"]
            let tempDoneTitle = self.tempDoneData["title"]
            let tempDoneDescription = self.tempDoneData["description"]

            let tempDoingStatus = self.tempDoingData["todoListItemStatus"]
            let tempDoingTitle = self.tempDoingData["title"]
            let tempDoingDescription = self.tempDoingData["description"]

            let tempTodoData = [
                Todo(todoListItemStatus: TodoListItemStatus(rawValue: tempTodoStatus!)!, title: tempTodoTitle!, description: tempTodoDescription!, date: Date()),
                Todo(todoListItemStatus: TodoListItemStatus(rawValue: tempDoneStatus!)!, title: tempDoneTitle!, description: tempDoneDescription!, date: Date()),
                Todo(todoListItemStatus: TodoListItemStatus(rawValue: tempDoingStatus!)!, title: tempDoingTitle!, description: tempDoingDescription!, date: Date())
            ]
            
            return tempTodoData
    }
    
    func save(todoListData: [Todo]) {
        self.data.accept(self.data.value + todoListData)
    }
}
