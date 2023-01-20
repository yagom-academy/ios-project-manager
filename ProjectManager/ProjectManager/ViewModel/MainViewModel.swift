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
            if let index = todoList.firstIndex(of: data) {
                todoList[index] = data
            } else {
                todoList.append(data)
            }
        case .doing:
            if let index = doingList.firstIndex(of: data) {
                doingList[index] = data
            } else {
                doingList.append(data)
            }
        case .done:
            if let index = doneList.firstIndex(of: data) {
                doneList[index] = data
            } else {
                doneList.append(data)
            }
        }
    }
    
    func moveWork(data: Work, category: Category) {
        // 얘는 무조건 어펜드
        switch data.category {
        case .todo:
            guard let index = todoList.firstIndex(of: data) else { return }
            todoList.remove(at: index)
        case .doing:
            guard let index = doingList.firstIndex(of: data) else { return }
            doingList.remove(at: index)
        case .done:
            guard let index = doneList.firstIndex(of: data) else { return }
            doneList.remove(at: index)
        }
        updateWork(data: Work(category: category, title: data.title, body: data.body, endDate: data.endDate))
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
