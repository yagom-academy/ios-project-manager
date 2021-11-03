//
//  ProjectModel.swift
//  ProjectManager
//
//  Created by 홍정아 on 2021/11/02.
//

import Foundation

struct ProjectModel {
    private(set) var projects: [Project]
    
    init(projects: [Project]) {
        self.projects = projects
    }
    
    struct Project: Identifiable {
        var id: UUID
        var title: String
        var content: String
        var dueDate: Date
        var created: Date
        var status: Status
    }
    
    enum Status: String {
        case todo
        case doing
        case done
        
        var header: String {
            return self.rawValue.uppercased()
        }
    }
}
