import Foundation

struct TaskList: Identifiable {
    var id: String
    var title: String
    var items: [Task]

    init(title: String, items: [Task] = []) {
        self.id = UUID().uuidString
        self.title = title
        self.items = items
    }
}
