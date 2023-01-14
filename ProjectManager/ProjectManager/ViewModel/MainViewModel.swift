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
    
    func uploadData(title: String, content: String? = nil, date: Date? = nil) {
        let data = Todo(title: title, content: content, deadLine: date)
        todoData.append(data)
    }
}
