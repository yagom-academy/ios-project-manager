//
//  TodoListItemStatus.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/07.
//

import Foundation

enum TodoListItemStatus: String {
    case todo = "TODO"
    case doing = "DOING"
    case done = "DONE"
    
    var displayName: String {
        return self.rawValue
    }
}
