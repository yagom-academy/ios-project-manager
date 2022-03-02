import Foundation

struct Project: Identifiable {
    let id: UUID = UUID()
    var title: String
    var description: String
    var date: Date = Date()
    var status: ProjectState
}

enum ProjectState {
    case todo
    case doing
    case done
}
