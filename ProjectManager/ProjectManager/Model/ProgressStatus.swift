import Foundation

enum ProgressStatus: String {
    case todo
    case doing
    case done
    
    var name: String {
        switch self {
        case .todo:
            return "Todo"
        case .doing:
            return "Doing"
        case .done:
            return "Done"
        }
    }
}
