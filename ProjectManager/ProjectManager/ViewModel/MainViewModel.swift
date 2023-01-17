//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/12.
//

import Foundation

final class MainViewModel {
    private var uploadDataProcess: Process?
    private var uploadDataIndex: Int?
    
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
}

// MARK: - Method
extension MainViewModel {
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
    
    func updateData(data: Todo) {
        guard let index = uploadDataIndex else {
            todoData.append(data)
            return
        }
        
        guard let process = uploadDataProcess else { return }
        
        switch process {
        case .todo:
            todoData[index] = data
        case .doing:
            doingData[index] = data
        case .done:
            doneData[index] = data
        }
    }
    
    func fetchSeletedData() -> Todo? {
        guard let process = uploadDataProcess else { return nil }
        guard let index = uploadDataIndex else { return nil }
        
        switch process {
        case .todo:
            return todoData[index]
        case .doing:
            return doingData[index]
        case .done:
            return doneData[index]
        }
    }
    
    func deleteData() {
        guard let index = uploadDataIndex else { return }
        guard let process = uploadDataProcess else { return }
        
        switch process {
        case .todo:
            todoData.remove(at: index)
        case .doing:
            doingData.remove(at: index)
        case .done:
            doneData.remove(at: index)
        }
    }
    
    func setupUploadDataProcess(process: Process) {
        uploadDataProcess = process
    }
    
    func setupUploadDataIndex(index: Int?) {
        uploadDataIndex = index
    }
    
    func resetUploadProcessIndex() {
        uploadDataIndex = nil
        uploadDataProcess = nil
    }
}
