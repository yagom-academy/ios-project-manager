//
//  DataManager.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/14.
//

import Foundation

final class DataManager {
    static let shared = DataManager()

    private var todoData: [Todo] = [] {
        didSet {
            onUpdated()
        }
    }
    
    private var doingData: [Todo] = [] {
        didSet {
            onUpdated()
        }
    }
    
    private var doneData: [Todo] = [] {
        didSet {
            onUpdated()
        }
    }
    
    var onUpdated: () -> Void = {}
    
    private init() { }
    
    func fetchData(process: Process) -> [Todo] {
        switch process {
        case .todo:
            return todoData
        case .doing:
            return doingData
        case .done:
            return doneData
        }
    }
    
    func appendData(process: Process, data: Todo) {
        switch process {
        case .todo:
            todoData.append(data)
        case .doing:
            doingData.append(data)
        case .done:
            doneData.append(data)
        }
    }
    
    func updateData(process: Process, data: Todo, indexPath: IndexPath) {
        switch process {
        case .todo:
            todoData[indexPath.row] = data
        case .doing:
            doingData[indexPath.row] = data
        case .done:
            doneData[indexPath.row] = data
        }
    }
}
