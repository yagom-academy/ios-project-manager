//
//  State.swift
//  ProjectManager
//
//  Created by steven on 7/26/21.
//

import Foundation

enum TaskType: String, CustomStringConvertible, Codable, CaseIterable {
    case todo = "TODO"
    case doing = "DOING"
    case done = "DONE"
    
    var description: String {
        return self.rawValue
    }
}
