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

enum ProjectState {
    case todo
    case doing
    case done
}
