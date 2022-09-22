//
//  TaskState.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/17.
//

enum TaskState: CaseIterable {
    case todo, doing, done

    var name: String {
        switch self {
        case .todo:
            return "TODO"
        case .doing:
            return "DOING"
        case .done:
            return "DONE"
        }
    }

    var title: [String] {
        switch self {
        case .todo:
            return ["Move to DOING", "Move to DONE"]
        case .doing:
            return ["Move to TODO", "Move to DONE"]
        case .done:
            return ["Move to TODO", "Move to DOING"]
        }
    }

    var other: [TaskState] {
        switch self {
        case .todo:
            return [.doing, .done]
        case .doing:
            return [.todo, .done]
        case .done:
            return [.todo, .doing]
        }
    }
}
