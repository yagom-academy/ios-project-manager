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
    var identifier: UUID { get }
    init(title: String, description: String, deadline: Date, state: PlanState, identifier: UUID)
}

struct Project: Plan {

    var title: String
    var description: String
    var deadline: Date
    var state: PlanState
    let identifier: UUID

    init(title: String, description: String, deadline: Date, state: PlanState = .toDo, identifier: UUID = UUID()) {
        self.title = title
        self.description = description
        self.deadline = deadline
        self.state = state
        self.identifier = identifier
    }
}

enum PlanState {

    case toDo
    case doing
    case done
}
