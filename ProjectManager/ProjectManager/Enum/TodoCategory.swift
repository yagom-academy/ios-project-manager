//
//  TodoCategory.swift
//  ProjectManager
//
//  Created by Baek on 2022/09/13.
//

import Foundation

enum TodoCategory: String {
    case todo = "TODO"
    case doing = "DOING"
    case done = "DONE"
    
    var value: String {
        return self.rawValue
    }
}
