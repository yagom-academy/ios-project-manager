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
        totalWorkList.filter { work in
            work.category == .todo
        }
    }
    
    var doingList: [Work] {
        totalWorkList.filter { work in
            work.category == .doing
        }
    }
    
    var doneList: [Work] {
        totalWorkList.filter { work in
            work.category == .done
        }
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
