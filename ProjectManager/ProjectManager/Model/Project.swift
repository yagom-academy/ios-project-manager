import Foundation

struct Project: Equatable {
    var title: String?
    var body: String?
    var date: TimeInterval
    var state: ProjectState
    var id: UUID?
    
    init(title: String, body: String, date: TimeInterval) {
        self.title = title
        self.body = body
        self.date = date
        self.state = ProjectState.todo
        self.id = UUID()
    }
}
