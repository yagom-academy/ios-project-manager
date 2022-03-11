import Foundation

struct Task: Identifiable {
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
    
    var id: UUID
    var title: String
    var deadline: TimeInterval
    var description: String
    var progressStatus: ProgressStatus
    
    init(title: String, description: String, deadline: Date) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.deadline = deadline.timeIntervalSince1970
        self.progressStatus = .todo
    }
}
