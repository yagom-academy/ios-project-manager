//
//  Project.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/17.
//

import Foundation

struct Project: Identifiable {
    let id = UUID()
    var state = ProjectState.todo
    var title: String
    var body: String
    var date: Date
}
