//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/12.
//

import Foundation

final class MainViewModel {
    private var todoData: [Todo] = [] {
        didSet {
            todoHandler?(todoData)
        }
    }
    private var doingData: [Todo] = [] {
        didSet {
            doingHandler?(doingData)
        }
    }
    private var doneData: [Todo] = [] {
        didSet {
            doneHandler?(doneData)
        }
    }
    
    private var todoHandler: (([Todo]) -> Void)?
    private var doingHandler: (([Todo]) -> Void)?
    private var doneHandler: (([Todo]) -> Void)?
    
    func bindTodo(handler: @escaping ([Todo]) -> Void) {
        handler(todoData)
        self.todoHandler = handler
    }
    
    func bindDoing(handler: @escaping ([Todo]) -> Void) {
        handler(doingData)
        self.doingHandler = handler
    }
    
    func bindDone(handler: @escaping ([Todo]) -> Void) {
        handler(doneData)
        self.doneHandler = handler
    }
}
