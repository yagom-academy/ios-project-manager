import Foundation

struct Project {
    let id: UUID
    let state: State
    let title: String
    let body: String
    let date: Date
}

extension Project: Equatable {
    static func ==(lhs: Project, rhs: Project) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.body == rhs.body && lhs.date == rhs.date && lhs.state == rhs.state
    }
}
