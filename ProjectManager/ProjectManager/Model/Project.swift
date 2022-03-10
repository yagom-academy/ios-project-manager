import Foundation

struct Project {
    enum State {
        case todo
        case doing
        case done
    }
    let id: UUID
    let state: State
    let title: String
    let body: String
    let date: Date
}
