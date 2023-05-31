//
//  State.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/24.
//

enum State: CustomStringConvertible {
    case todo, doing, done
    
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
    func checkOrder() -> (first: String, second: String) {
        switch self {
        case .todo:
            return (String(describing: State.doing), String(describing: State.done))
        case .doing:
            return (String(describing: State.todo), String(describing: State.done))
        case .done:
            return (String(describing: State.todo), String(describing: State.doing))
        }
    }
    
    func moveByState() -> (first: State, second: State) {
        switch self {
        case .todo:
            return (State.doing, State.done)
        case .doing:
            return (State.todo, State.done)
        case .done:
            return (State.todo, State.doing)
        }
    }
}
