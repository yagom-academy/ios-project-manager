//
//  TaskState.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/18.
//

enum TaskState: CaseIterable {
    case todo
    case doing
    case done
    
    var description: String {
        switch self {
        case .todo:
            return "TODO"
        case .doing:
            return "DOING"
        case .done:
            return "DONE"
        }
    }
}

extension TaskState {
    var others: (first: TaskState, second: TaskState) {
        let stateList = TaskState.allCases.filter { $0 != self }
        
        return (stateList[0], stateList[1])
    }
}
