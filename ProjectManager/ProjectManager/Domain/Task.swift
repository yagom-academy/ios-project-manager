import Foundation

struct Task: Identifiable {
    var id: String
    var title: String
    var body: String
    var dueDate: String
    var lastModifiedDate: String

    init(title: String, dueDate: String, lastModifiedDate: String, body: String = "") {
        self.id = UUID().uuidString
        self.title = title
        self.body = body
        self.dueDate = dueDate
        self.lastModifiedDate = lastModifiedDate
    }
}
