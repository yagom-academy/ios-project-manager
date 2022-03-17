import Foundation

enum ProjectState {
    case todo
    case doing
    case done
    
    var title: String {
        switch self {
        case .todo:
            return "TODO"
        case .doing:
            return "DOING"
        case .done:
            return "DONE"
        }
    }
    
    var alertActionTitle: String {
        switch self {
        case .todo:
            return "Move to Todo"
        case .doing:
            return "Move to Doing"
        case .done:
            return "Move to Done"
        }
    }
}
