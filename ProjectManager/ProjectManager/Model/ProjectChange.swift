//
//  ProjectChange.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/26.
//

import Foundation

enum ProjectChange: Hashable {
    
    case add
    case remove(from: ProjectState)
    case update
    case move(from: ProjectState, to: ProjectState)
}
