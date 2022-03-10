import Foundation

final class Task: Codable, Equatable {
    var id: UUID
    var title: String
    var body: String
    var dueDate: Date
    var processStatus: ProcessStatus
    
    init(title: String, body: String, dueDate: Date, processStatus: ProcessStatus = .todo) {
        self.id = UUID()
        self.title = title
        self.body = body
        self.dueDate = dueDate
        self.processStatus = processStatus
    }
    
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
                && lhs.title == rhs.title
                && lhs.body == rhs.body
                && lhs.dueDate == rhs.dueDate
                && lhs.processStatus == rhs.processStatus
    }
    
    func changeId(to id: UUID) {
        self.id = id
    }
}
