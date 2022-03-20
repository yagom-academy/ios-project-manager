import Foundation

enum TaskStatus: String, CaseIterable, Identifiable {
    case todo
    case doing
    case done
    
    var id: UUID { UUID() }
    
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
