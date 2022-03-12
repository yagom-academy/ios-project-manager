import Foundation

class TaskListEntity: Identifiable {
    var id: UUID
    var title: String
    var items: [TaskEntity]

    init(title: String, items: [TaskEntity] = []) {
        self.id = UUID()
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

    init(title: String, dueDate: Date, lastModifiedDate: Date = Date(), body: String = "") {
        self.id = UUID()
        self.title = title
        self.body = body
        self.dueDate = dueDate
        self.lastModifiedDate = lastModifiedDate
    }
}
