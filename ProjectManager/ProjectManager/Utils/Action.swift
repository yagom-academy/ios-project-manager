//
//  Action.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/22.
//

import Foundation

enum Action: String {
    case moved = "Moved"
    case added = "Added"
    case edited = "Edited"
    case removed = "Removed"
    
    var description: String {
        return self.rawValue
    }
}
