import Foundation

struct TaskEntity: Identifiable {
    
    enum Status {
        case ToDo
        case InProgress
        case Done
    }
    
    var id: UUID
    var title: String
    var body: String
    var status: Status
    var dueDate: Date?

    init(title: String,
         body: String = "",
         status: Status = .ToDo,
         dueDate: Date? = nil
    ) {
        self.id = UUID()
        self.title = title
        self.body = body
        self.status = status
        self.dueDate = dueDate
    }
}
