import Foundation

class Task: Codable {
    let id: UUID
    var title: String
    var body: String
    var dueDate: Date
    var processStatus: ProcessStatus
    
    init(title: String, body: String, dueDate: Date) {
        self.id = UUID()
        self.title = title
        self.body = body
        self.dueDate = dueDate
        self.processStatus = .todo
    }
}
