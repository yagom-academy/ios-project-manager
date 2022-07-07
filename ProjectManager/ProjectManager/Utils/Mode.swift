//
//  Mode.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/07.
//

import Foundation

enum Mode: String {
    case todo = "TODO"
    case doing = "DOING"
    case done = "DONE"
    
    var value: String {
        return self.rawValue
    }
}
