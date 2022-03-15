import Foundation

struct TaskList: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var items: [Task] = []
    var lastModifiedDate: String = Date().formatToString()
}
