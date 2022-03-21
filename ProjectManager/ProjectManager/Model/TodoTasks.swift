//
//  TodoTasks.swift
//  ProjectManager
//
//  Created by 고은 on 2022/03/03.
//

import Foundation

enum TodoTasks: String, CaseIterable {

    case todo = "TODO"
    case doing = "DOING"
    case done = "DONE"

    static func getTask(_ task: Int) -> TodoTasks {
        self.allCases[task]
    }
}
