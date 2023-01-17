//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/12.
//

import Foundation

final class MainViewModel {
    private var updateDataProcess: Process?
    private var updateDataIndex: Int?
    
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
        guard let index = updateDataIndex else {
            todoData.append(data)
            return
        }
        
        guard let process = updateDataProcess else { return }
        
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
        guard let process = updateDataProcess else { return nil }
        guard let index = updateDataIndex else { return nil }
        
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
        guard let index = updateDataIndex else { return }
        guard let process = updateDataProcess else { return }
        
        switch process {
        case .todo:
            todoData.remove(at: index)
        case .doing:
            doingData.remove(at: index)
        case .done:
            doneData.remove(at: index)
        }
    }
    
    func changeProcess(after: Process, index: Int) {
        guard let index = updateDataIndex else { return }
        guard let process = updateDataProcess else { return }
        
        switch process {
        case .todo:
            if after == .doing {
                doingData.append(todoData.remove(at: index))
            } else {
                doneData.append(todoData.remove(at: index))
            }
        case .doing:
            if after == .todo {
                todoData.append(doingData.remove(at: index))
            } else {
                doneData.append(doingData.remove(at: index))
            }
        case .done:
            if after == .todo {
                todoData.append(doneData.remove(at: index))
            } else {
                doingData.append(doneData.remove(at: index))
            }
        }
    }
    
    func setupUploadDataProcess(process: Process) {
        updateDataProcess = process
    }
    
    func setupUploadDataIndex(index: Int?) {
        updateDataIndex = index
    }
    
    func resetUpdateInfo() {
        updateDataIndex = nil
        updateDataProcess = nil
    }
}
