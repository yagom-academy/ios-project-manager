import Foundation

struct TaskListModel: Identifiable {
    var id: UUID = UUID()
    var title: String
    var items: [TaskModel] = []
    var lastModifiedDate: Date = Date()
    var creationDate: Date
}
