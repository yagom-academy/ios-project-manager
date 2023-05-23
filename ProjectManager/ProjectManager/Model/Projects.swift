//
//  ProjectManager - Projects.swift
//  Created by Rhode.
//  Copyright © yagom. All rights reserved.
//

import Foundation

final class Projects {
    static let shared = Projects()
    
    private init() { }
    
    var list: [Project] = [Project(title: "할 일1", body: "할 일1", date: Date(timeIntervalSince1970: Date().timeIntervalSince1970-30000), status: .todo), Project(title: "할 일2", body: "할 일2", date: Date(timeIntervalSince1970: Date().timeIntervalSince1970-60000), status: .todo), Project(title: "할 일3", body: "할 일3", date: Date(timeIntervalSince1970: Date().timeIntervalSince1970-90000), status: .todo), Project(title: "할 일4", body: "할 일4", date: Date(timeIntervalSince1970: Date().timeIntervalSince1970-120000), status: .todo), Project(title: "할 일5", body: "할 일5", date: Date(timeIntervalSince1970: Date().timeIntervalSince1970-150000), status: .todo), Project(title: "할 일6", body: "할 일6", date: Date(timeIntervalSince1970: Date().timeIntervalSince1970-180000), status: .todo), Project(title: "할 일7", body: "할 일7", date: Date(timeIntervalSince1970: Date().timeIntervalSince1970-210000), status: .todo), Project(title: "할 일8", body: "할 8", date: Date(timeIntervalSince1970: Date().timeIntervalSince1970-240000), status: .todo)]
}
