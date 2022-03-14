import Foundation

struct Task: Identifiable {
    enum ProgressStatus: String, CaseIterable, Identifiable {
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
    
    var id: String
    var title: String
    var description: String
    var deadline: TimeInterval
    var progressStatus: ProgressStatus
    
    init(title: String, description: String, deadline: Date) {
        self.id = UUID().uuidString
        self.title = title
        self.description = description
        self.deadline = deadline.timeIntervalSince1970
        self.progressStatus = .todo
    }
    
    init(id: String, title: String, description: String, deadline: TimeInterval, progressStatus: ProgressStatus) {
        self.id = id
        self.title = title
        self.description = description
        self.deadline = deadline
        self.progressStatus = progressStatus
    }
}
