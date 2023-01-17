//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/12.
//

import Foundation

final class MainViewModel {
    var todoList: [Work] = [] {
        didSet {
            todoListHandler?(todoList)
        }
    }
    
    var doingList: [Work] = [] {
        didSet {
            doingListHandler?(doingList)
        }
    }
    
    var doneList: [Work] = [] {
        didSet {
            doneListHandler?(doneList)
        }
    }
    
    private var todoListHandler: (([Work]) -> Void)?
    private var doingListHandler: (([Work]) -> Void)?
    private var doneListHandler: (([Work]) -> Void)?
    
    func bindTodoList(handler: @escaping ([Work]) -> Void) {
        todoListHandler = handler
    }
    
    func bindDoingList(handler: @escaping ([Work]) -> Void) {
        doingListHandler = handler
    }
    
    func bindDoneList(handler: @escaping ([Work]) -> Void) {
        doneListHandler = handler
    }
    
    func updateWork(data: Work) {
        switch data.category {
        case .todo:
            let index = todoList.firstIndex { $0.id == data.id }
            
            if let index {
                todoList[index] = data
                return
            }
            todoList.append(data)
        case .doing:
            let index = doingList.firstIndex { $0.id == data.id }
            
            if let index {
                doingList[index] = data
                return
            }
            doingList.append(data)
        case .done:
            let index = doneList.firstIndex { $0.id == data.id }
            
            if let index {
                doneList[index] = data
                return
            }
            doneList.append(data)
        }
    }
    
    func moveWork(data: Work, category: Category) {
        switch data.category {
        case .todo:
            let index = todoList.firstIndex { $0.id == data.id }
            
            if let index {
                var work = todoList.remove(at: index)
                
                work.category = category
                updateWork(data: work)
            }
        case .doing:
            let index = doingList.firstIndex { $0.id == data.id }
            
            if let index {
                var work = doingList.remove(at: index)
                work.category = category
                updateWork(data: work)
            }
        case .done:
            let index = doneList.firstIndex { $0.id == data.id }
            
            if let index {
                var work = doneList.remove(at: index)
                work.category = category
                updateWork(data: work)
            }
        }
    }
    
    func deleteWork(data: Work) {
        switch data.category {
        case .todo:
            todoList = todoList.filter { $0.id != data.id }
        case .doing:
            doingList = doingList.filter { $0.id != data.id }
        case .done:
            doneList = doneList.filter { $0.id != data.id }
        }
    }
}
