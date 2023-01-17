//
//  WorkManager.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/15.
//

import Foundation

class WorkManager {
    var totalWorkList: [Work] = []
    
    var todoList: [Work] {
        totalWorkList.filter { $0.category == .todo }
    }
    
    var doingList: [Work] {
        totalWorkList.filter { $0.category == .doing }
    }
    
    var doneList: [Work] {
        totalWorkList.filter { $0.category == .done }
    }
    
    func registerWork(data: Work) {
        totalWorkList.append(data)
    }
    
    func moveWork(data: Work, category: Category) {
        let dataIndex = totalWorkList.firstIndex { data.id == $0.id }
        totalWorkList[dataIndex!].category = category
    }
    
    func deleteWork(data: Work) {
        totalWorkList = totalWorkList.filter { data.id != $0.id }
    }
    
}
