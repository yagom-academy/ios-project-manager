//  ProjectManager - ToDoState.swift
//  created by zhilly on 2023/01/13

enum ToDoState: Int16 {
    case toDo = 1
    case doing = 2
    case done = 3
}

extension ToDoState: CustomStringConvertible {
    var description: String {
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
