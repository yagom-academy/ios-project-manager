//
//  Project.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/17.
//

import Foundation

struct Project: Identifiable, Equatable {
    let id = UUID()
    var state = ProjectState.todo
    var title: String
    var body: String
    var date: Date
    
    public static func ==(lhs: Project, rhs: Project) -> Bool {
        if lhs.id == rhs.id {
            return true
        } else {
            return false
        }
     }
}
