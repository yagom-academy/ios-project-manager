//  ProjectManager - ToDoState.swift
//  created by zhilly on 2023/01/13

enum ToDoState {
    case toDo
    case doing
    case done
    
    var name: String {
        switch self {
        case .toDo:
            return "TODO"
        case .doing:
            return "DOING"
        case .done:
            return "DONE"
        }
    }
}
