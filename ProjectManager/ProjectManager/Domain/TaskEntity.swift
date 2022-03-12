import Foundation

class TaskListEntity: Identifiable {
    var id: UUID
    var title: String
    var items: [TaskEntity]

    init(title: String,
         id: UUID = UUID(),
         items: [TaskEntity] = []) {
        self.id = id
        self.title = title
        self.items = items
    }
}

public class TaskEntity: NSObject, Identifiable {
    public var id: UUID
    var title: String
    var body: String
    var dueDate: Date
    var lastModifiedDate: Date

    init(title: String,
         dueDate: Date,
         id: UUID = UUID(),
         body: String = "",
         lastModifiedDate: Date = Date()) {
        self.id = id
        self.title = title
        self.body = body
        self.dueDate = dueDate
        self.lastModifiedDate = lastModifiedDate
    }
}
