//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/12.
//

import Foundation

final class MainViewModel {
    private var todoData: [Plan] = [] {
        didSet {
            todoHandler?(todoData)
        }
    }
    
    private var doingData: [Plan] = [] {
        didSet {
            doingHandler?(doingData)
        }
    }
    
    private var doneData: [Plan] = [] {
        didSet {
            doneHandler?(doneData)
        }
    }
    
    private var popOverProcessList: [Process] = [] {
        didSet {
            processListHandler?(popOverProcessList)
        }
    }
    
    private(set) var movePlan: MovePlan?
    
    private var todoHandler: (([Plan]) -> Void)?
    private var doingHandler: (([Plan]) -> Void)?
    private var doneHandler: (([Plan]) -> Void)?
    private var processListHandler: (([Process]) -> Void)?
}

// MARK: - Method
extension MainViewModel {
    func bindTodo(handler: @escaping ([Plan]) -> Void) {
        handler(todoData)
        self.todoHandler = handler
    }
    
    func bindDoing(handler: @escaping ([Plan]) -> Void) {
        handler(doingData)
        self.doingHandler = handler
    }
    
    func bindDone(handler: @escaping ([Plan]) -> Void) {
        handler(doneData)
        self.doneHandler = handler
    }
    
    func bindProcessList(handler: @escaping ([Process]) -> Void) {
        self.processListHandler = handler
    }
    
    func updateData(data: Plan, process: Process, index: Int?) {
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
    
    func fetchSeletedData(process: Process, index: Int?) -> Plan? {
        guard let index = index else { return nil }
        
        switch process {
        case .todo:
            guard index < todoData.count else { return nil }
            return todoData[index]
        case .doing:
            guard index < doingData.count else { return nil }
            return doingData[index]
        case .done:
            guard index < doneData.count else { return nil }
            return doneData[index]
        }
    }
    
    func deleteData(process: Process, index: Int) {
        switch process {
        case .todo:
            guard index < todoData.count else { return }
            todoData.remove(at: index)
        case .doing:
            guard index < doingData.count else { return }
            doingData.remove(at: index)
        case .done:
            guard index < doneData.count else { return }
            doneData.remove(at: index)
        }
    }
    
    func changeProcess(_ after: Process) {
        guard let before = movePlan?.beforeProcess else { return }
        guard let index = movePlan?.index else { return }
        
        switch before {
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
        
        movePlan = nil
    }
    
    func configureMovePlan(_ movePlan: MovePlan) {
        self.movePlan = movePlan
        popOverProcessList = configureButton(process: movePlan.beforeProcess)
    }
    
    private func configureButton(process: Process) -> [Process] {
        return Process.allCases.filter {
            $0 != process
        }
    }
}
