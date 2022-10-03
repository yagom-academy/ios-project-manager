//
//  Project.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/11.
//

import Foundation

struct Project {
    let uuid: UUID
    var status: Status = .todo
    let title: String
    let description: String
    let date: Date
}
