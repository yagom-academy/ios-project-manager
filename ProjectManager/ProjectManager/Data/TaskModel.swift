import Foundation

public class TaskModel: NSObject, Identifiable {
    public var id: UUID
    var title: String
    var body: String
    var dueDate: Date
    var lastModifiedDate: Date

    init(title: String,
         id: UUID = UUID(),
         body: String = "",
         dueDate: Date = Date(),
         lastModifiedDate: Date = Date()) {
        self.id = id
        self.title = title
        self.body = body
        self.dueDate = dueDate
        self.lastModifiedDate = lastModifiedDate
    }
}
