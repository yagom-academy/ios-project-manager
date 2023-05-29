//
//  Project.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/17.
//

import Foundation

final class Project: Identifiable {
    let id = UUID()
    var state = ProjectState.todo
    var title: String
    var body: String
    var date: Date
    
    init(state: ProjectState = ProjectState.todo, title: String, body: String, date: Date) {
        self.state = state
        self.title = title
        self.body = body
        self.date = date
    }
}
