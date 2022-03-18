import Foundation

struct Task: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var body: String = ""
    var dueDate: String = Date().formatToString()
    var lastModifiedDate: String = Date().formatToString()
}
