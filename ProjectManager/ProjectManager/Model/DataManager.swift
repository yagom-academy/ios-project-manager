//
//  DataManager.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/14.
//

import Foundation

final class DataManager {
    static let shared = DataManager()

    private var todoData: [Todo] = []
    private var doingData: [Todo] = []
    private var doneData: [Todo] = []
    
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
}
