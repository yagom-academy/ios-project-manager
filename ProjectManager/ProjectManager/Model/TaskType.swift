//
//  State.swift
//  ProjectManager
//
//  Created by steven on 7/26/21.
//

import Foundation

enum TaskType: String, CustomStringConvertible, Codable, CaseIterable {
    case todo
    case doing
    case done
    
    var description: String {
        return self.rawValue.uppercased()
    }
}
