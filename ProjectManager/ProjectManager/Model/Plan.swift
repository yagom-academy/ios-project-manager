//
//  Plan.swift
//  ProjectManager
//
//  Created by Gundy on 2023/01/11.
//

import Foundation

protocol Plan {
    var title: String { get set }
    var description: String { get set }
    var deadline: Date { get set }
    var state: PlanState { get set }
}

struct ToDo: Plan {
    var title: String
    var description: String
    var deadline: Date
    var state: PlanState

    init(title: String, description: String, deadline: Date, state: PlanState = .toDo) {
        self.title = title
        self.description = description
        self.deadline = deadline
        self.state = state
    }
}

enum PlanState {

    case toDo
    case doing
    case done
}
