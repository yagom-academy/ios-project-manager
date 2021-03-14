//
//  ItemList.swift
//  ProjectManager
//
//  Created by 김동빈 on 2021/03/12.
//

import Foundation

class ItemList {
    static let shared = ItemList()
    private init() {
        todoList.append(contentsOf: [todo1, todo2])
        doingList.append(contentsOf: [todo2, todo1])
        doneList.append(todo1)
    }
    
    private var todoList = [Todo]()
    private var doingList = [Todo]()
    private var doneList = [Todo]()
    
    private var todo1 = Todo(title: "무야호", description: "그만큼 기분이 좋으시다는거지.", deadLine: Date())
    private var todo2 = Todo(title: "UI 만들기", description: "잘 하고 있어....!!!잘 하고 있어....!!!잘 하고 있어....!!!잘 하고 있어....!!!잘 하고 있어....!!!잘 하고 있어....!!!", deadLine: Date())
    
    func countListItem(statusType: ItemStatus) -> Int {
        switch statusType {
        case .todo:
            return todoList.count
        case .doing:
            return doingList.count
        case .done:
            return doneList.count
        }
    }
    
    func getItem(statusType: ItemStatus, index: Int) -> Todo {
        switch statusType {
        case .todo:
            return todoList[index]
        case .doing:
            return doingList[index]
        case .done:
            return doneList[index]
        }
    }
    
    func removeItem(statusType: ItemStatus, index: Int) {
        switch statusType {
        case .todo:
            todoList.remove(at: index)
        case .doing:
            doingList.remove(at: index)
        case .done:
            doneList.remove(at: index)
        }
    }
    
    func insertItem(statusType: ItemStatus, index: Int = 0, item: Todo)  {
        switch statusType {
        case .todo:
            todoList.insert(item, at: index)
        case .doing:
            doingList.insert(item, at: index)
        case .done:
            doneList.insert(item, at: index)
        }
    }
    
    func updateItem(statusType: ItemStatus, index: Int, item: Todo) {
        switch statusType {
        case .todo:
            todoList[index] = item
        case .doing:
            doingList[index] = item
        case .done:
            doneList[index] = item
        }
    }
}
