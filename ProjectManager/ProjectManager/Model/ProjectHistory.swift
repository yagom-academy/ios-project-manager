//
//  ProjectHistory.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/26.
//

import Foundation

struct ProjectHistory: Hashable {
    
    let Project: Project
    let change: ProjectChange
    let changeDate: Date = Date()
}
