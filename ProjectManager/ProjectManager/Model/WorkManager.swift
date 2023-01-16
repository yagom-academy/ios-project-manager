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
    
    func getWorkList() {
        
    }
    
    func registerWork(data: Work) {
        totalWorkList.append(data)
    }
    
    func updateWork() {
        
    }
    
    func deleteWork() {
        
    }
    
}
