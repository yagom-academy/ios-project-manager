//
//  Project.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/13.
//

import Foundation

struct Project: Hashable {
    
    var title: String?
    var description: String?
    var date: Date
    let uuid: UUID
}
