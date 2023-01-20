//
//  Project.swift
//  ProjectManager
//
//  Created by Hamo, Wonbi on 2023/01/16.
//

import Foundation

struct Project: Hashable {
    let id: UUID = UUID()
    var title: String
    var deadline: Calendar
    var description: String
    var state: State
}
