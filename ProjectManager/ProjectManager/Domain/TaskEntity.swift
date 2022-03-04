import Foundation

enum TaskStatus {
    case ToDo
    case InProgress
    case Done
}

struct TaskEntity: Identifiable {
    var id: UUID
    var title: String
    var body: String
    var status: TaskStatus
    var dueDate: Date?

    init(title: String, body: String = "", status: TaskStatus = .ToDo, dueDate: Date? = nil) {
        self.id = UUID()
        self.title = title
        self.body = body
        self.status = status
        self.dueDate = dueDate
    }
}
