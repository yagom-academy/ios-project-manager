//
//  State.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/18.
//

enum State: CaseIterable {
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

extension State {
    var others: (first: State, second: State) {
        var stateList = State.allCases.filter { $0 != self }
        
        return (stateList[0], stateList[1])
    }
}
