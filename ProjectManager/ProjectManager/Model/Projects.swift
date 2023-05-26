//
//  ProjectManager - Projects.swift
//  Created by Rhode.
//  Copyright © yagom. All rights reserved.
//

import Foundation

final class Projects {
    static let shared = Projects()
    
    private init() { }
    
    var list: [Project] = {
        var list = [Project]()
        
        for i in 1...1 {
            let project = Project(title: "프로젝트 \(i)", body: "프로젝트 \(i)에 대한 설명", date: Date()-TimeInterval(i*10000), status: .todo)
            list.append(project)
        }
        
        for i in 1...11 {
            let project = Project(title: "프로젝트 \(i)", body: "프로젝트 \(i)에 대한 설명", date: Date()-TimeInterval(i*10000), status: .doing)
            list.append(project)
        }
        
        for i in 1...111 {
            let project = Project(title: "프로젝트 \(i)", body: "프로젝트 \(i)에 대한 설명", date: Date()-TimeInterval(i*10000), status: .done)
            list.append(project)
        }
        
        return list
    }()
}
