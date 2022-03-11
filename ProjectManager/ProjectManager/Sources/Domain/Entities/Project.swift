import Foundation

struct Project {
    let id: UUID
    var title: String
    var description: String
    var date: Date
    var status: ProjectState
}

extension Project {
    init(title: String, description: String, date: Date) {
        self.init(
            id: UUID(),
            title: title,
            description: description,
            date: Date(),
            status: .todo
        )
    }
}

enum ProjectState: String, CaseIterable {
    case todo = "TODO"
    case doing = "DOING"
    case done = "DONE"
    
    var index: Int {
        switch self {
        case .todo:
            return 0
        case .doing:
            return 1
        case .done:
            return 2
        }
    }
}
