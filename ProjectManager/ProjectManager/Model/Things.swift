//
//  Things.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/09.
//

import UIKit
import MobileCoreServices

final class Things {
    private var todoList: [Thing] = []
    private var doingList: [Thing] = []
    private var doneList: [Thing] = []
    static let shared = Things()
    private init() {}
    
    func createData(thing: Thing) {
        todoList.insert(thing, at: 0)
        NotificationCenter.default.post(name: Notification.Name(TableViewType.todo.rawValue), object: nil)
    }
    
    func updateData(thing: Thing, tableViewType: TableViewType, index: Int) {
        switch tableViewType {
        case .todo:
            todoList[index] = thing
        case .doing:
            doingList[index] = thing
        case .done:
            doneList[index] = thing
        }
        NotificationCenter.default.post(name: Notification.Name(tableViewType.rawValue), object: nil)
    }
    
    func deleteThing(at index: Int, _ tableViewType: TableViewType, _ completionHandler: @escaping () -> Void) {
        switch tableViewType {
        case .todo:
            if index < Things.shared.todoList.count {
                Things.shared.todoList.remove(at: index)
            }
        case .doing:
            if index < Things.shared.doingList.count {
                Things.shared.doingList.remove(at: index)
            }
        case .done:
            if index < Things.shared.doneList.count {
                Things.shared.doneList.remove(at: index)
            }
        }
        completionHandler()
    }
    
    func getThing(at index: Int, _ tableViewType: TableViewType) -> Thing? {
        switch tableViewType {
        case .todo:
            if index < Things.shared.todoList.count {
                return Things.shared.todoList[index]
            }
        case .doing:
            if index < Things.shared.doingList.count {
                return Things.shared.doingList[index]
            }
        case .done:
            if index < Things.shared.doneList.count {
                return Things.shared.doneList[index]
            }
        }
        return nil
    }
    
    func getThingListCount(_ tableViewType: TableViewType) -> Int {
        switch tableViewType {
        case .todo:
            return Things.shared.todoList.count
        case .doing:
            return Things.shared.doingList.count
        case .done:
            return Things.shared.doneList.count
        }
    }
    
    func insertThing(_ thing: Thing, at index: Int, _ tableViewType: TableViewType) {
        switch tableViewType {
        case .todo:
            if index <= Things.shared.todoList.count {
                Things.shared.todoList.insert(thing, at: index)
            }
        case .doing:
            if index <= Things.shared.doingList.count {
                Things.shared.doingList.insert(thing, at: index)
            }
        case .done:
            if index <= Things.shared.doneList.count {
                Things.shared.doneList.insert(thing, at: index)
            }
        }
    }
}
