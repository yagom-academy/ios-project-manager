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
    
    func updateData(process: Process, data: Todo, index: Int?) {
        guard let index = index else {
            todoData.append(data)
            return
        }
        
        switch process {
        case .todo:
            todoData[index] = data
        case .doing:
            doingData[index] = data
        case .done:
            doneData[index] = data
        }
    }
    
    func fetchDataCount(process: Process) -> String {
        switch process {
        case .todo:
            return String(todoData.count)
        case .doing:
            return String(doingData.count)
        case .done:
            return String(doneData.count)
        }
    }
    
    func fetchSeletedData(process: Process, index: Int) -> Todo {
        switch process {
        case .todo:
            return todoData[index]
        case .doing:
            return doingData[index]
        case .done:
            return doneData[index]
        }
    }
}
