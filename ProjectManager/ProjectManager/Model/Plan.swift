//
//  Plan.swift
//  ProjectManager
//
//  Created by 이윤주 on 2021/11/15.
//

import Foundation

struct Plan: Identifiable {
    enum State: String, CaseIterable {
        case toDo = "TODO"
        case doing = "DOING"
        case done = "DONE"
        
        var description: String {
            return self.rawValue
        }
    }
    
    var state: State
    var title: String
    var description: String
    var deadline: Date
    var isOverdue: Bool = false
    var id = UUID()
}
