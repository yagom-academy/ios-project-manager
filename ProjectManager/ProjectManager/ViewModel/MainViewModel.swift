//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/12.
//

import Foundation

final class MainViewModel {
    private var totalWorkList: [Work] = [] {
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
    
    func searchWorkIndex(data: Work) -> Int? {
        return totalWorkList.firstIndex { $0.id == data.id }
    }

    func updateWork(data: Work) {
        if let index = searchWorkIndex(data: data) {
            totalWorkList[index] = data
            return
        }
        
        totalWorkList.append(data)
    }
    
    func moveWork(data: Work, category: Category) {
        guard let index = searchWorkIndex(data: data) else { return }
        totalWorkList[index].category = category
    }
    
    func deleteWork(data: Work) {
        totalWorkList = totalWorkList.filter { $0.id != data.id }
    }
}
