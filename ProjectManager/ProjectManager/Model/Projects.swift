//
//  ProjectManager - Projects.swift
//  Created by Rhode.
//  Copyright © yagom. All rights reserved.
//

import Foundation

class Projects {
    static let shared = Projects()
    
    private init() { }
    
    var projects: [Project] = [Project(title: "dd", body: "ds", status: .todo), Project(title: "afds", body: "fdsf", status: .todo), Project(title: "sf", body: "sdfds", status: .todo), Project(title: "dd", body: "ds", status: .todo), Project(title: "sf", body: "sdfds", status: .todo), Project(title: "dd", body: "ds", status: .todo), Project(title: "dd", body: "ds", status: .todo), Project(title: "afds", body: "fdsf", status: .todo), Project(title: "sf", body: "sdfds", status: .todo), Project(title: "dd", body: "ds", status: .todo), Project(title: "sf", body: "sdfds", status: .todo), Project(title: "dd", body: "ds", status: .todo)]
}
