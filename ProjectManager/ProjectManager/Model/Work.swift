//
//  Work.swift
//  ProjectManager
//
//  Created by BMO on 2023/10/01.
//

import Foundation

struct Work: Equatable, Sendable {
    let title: String
    let description: String
    let deadline: Date
    
    enum Status: String {
        case todo = "TODO"
        case doing = "DOING"
        case done = "DONE"
    }
}
