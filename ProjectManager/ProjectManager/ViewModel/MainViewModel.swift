//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/12.
//

import Foundation

class MainViewModel {
    var totalWorkList: [Work] = [] {
        didSet {
            reloadHandler?()
        }
    }
    
    var todoList: [Work] {
        totalWorkList.filter { $0.category == .todo }
    }
    
    var doingList: [Work] {
        totalWorkList.filter { $0.category == .doing }
    }
    
    var doneList: [Work] {
        totalWorkList.filter { $0.category == .done }
    }
    
    private var reloadHandler: (() -> Void)?
    
    func bind(handler: @escaping () -> Void) {
        reloadHandler = handler
    }

    func updateWork(data: Work) {
        let workIndex = totalWorkList.firstIndex { $0.id == data.id }
        
        if let workIndex {
            return totalWorkList[workIndex] = data
        }
        
        totalWorkList.append(data)
    }
    
    func moveWork(data: Work, category: Category) {
        let workIndex = totalWorkList.firstIndex { $0.id == data.id }
        
        if let workIndex {
            return totalWorkList[workIndex].category = category
        }
    }
    
    func deleteWork(data: Work) {
        totalWorkList = totalWorkList.filter { $0.id != data.id }
    }
}
