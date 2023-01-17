//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/12.
//

import Foundation

class MainViewModel {
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
    
    // 워크 매니저에 등록하고, 워크매니저는 배열을 리턴하는 로직으로 변경하자
    // 리턴한 배열은 workList라는 변수에 담아보도록하자
    func updateWork(data: Work) {
        let work = workManager.totalWorkList.filter { data.id == $0.id }
        
        if !work.isEmpty {
            workManager.deleteWork(data: data)
        }
        workManager.registerWork(data: data)
        reloadHandler?()
    }
    
    func moveWork(data: Work, category: Category) {
        workManager.moveWork(data: data, category: category)
        reloadHandler?()
    }
    
    func deleteWork(data: Work) {
        workManager.deleteWork(data: data)
        reloadHandler?()
    }
}
