//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/12.
//

import Foundation

class ListViewModel {
    
    let workManager = WorkManager()
    
    var todoList: [Work] {
        workManager.todoList
    }
    
    var doingList: [Work] {
        workManager.doingList
    }
    
    var doneList: [Work] {
        workManager.doneList
    }
    
    private var reloadHandler: (() -> Void)?
    
    func bind(handler: @escaping () -> Void) {
        reloadHandler = handler
    }
    
    func updateWork(data: Work) {
        workManager.registerWork(data: data)
        reloadHandler?()
    }
}
