import Foundation

struct Task: Identifiable {
    enum ProgressStatus: CaseIterable, Identifiable {
        var id: UUID { UUID() }
        
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
    var description: String
    var deadline: TimeInterval
    var progressStatus: ProgressStatus
    
    init(title: String, description: String, deadline: Date) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.deadline = deadline.timeIntervalSince1970
        self.progressStatus = .todo
    }
}
