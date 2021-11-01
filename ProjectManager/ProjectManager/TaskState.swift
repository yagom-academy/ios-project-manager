//
//  TaskState.swift
//  ProjectManager
//
//  Created by Dasoll Park on 2021/11/01.
//

import Foundation

enum TaskState: String, CustomStringConvertible {
    case todo
    case doing
    case done
    
    var description: String {
        return self.rawValue.uppercased()
    }
}

