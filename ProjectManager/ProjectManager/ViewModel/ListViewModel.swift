//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/12.
//

import Foundation

class ListViewModel {
    
    let workManager: WorkManager
    
    init(workManager: WorkManager) {
        self.workManager = workManager
    }
    
    var workList: [Work] = [] {
        didSet {
            workListHandler?(workList)
        }
    }
    
    private var workListHandler: (([Work]) -> Void)?
    
    func workTodoList(handler: @escaping ([Work]) -> Void) {
        workListHandler = handler
    }
    
    func fetchData() {
        workList = workManager.todoList
    }
}
