//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/12.
//

import Foundation

final class MainViewModel {
    private let dataManager = DataManager.shared
    
    private var todoData: [Todo] = [] {
        didSet {
            binding()
        }
    }
    private var doingData: [Todo] = [] {
        didSet {
            binding()
        }
    }
    private var doneData: [Todo] = [] {
        didSet {
            binding()
        }
    }
    
    var binding: () -> Void = {}
    
    init() {
        todoData = dataManager.fetchData(process: .todo)
        doingData = dataManager.fetchData(process: .doing)
        doneData = dataManager.fetchData(process: .done)
        dataManager.onUpdated = { [weak self] in
            guard let self = self else { return }
            self.todoData = self.dataManager.fetchData(process: .todo)
        }
    }
    
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
}
