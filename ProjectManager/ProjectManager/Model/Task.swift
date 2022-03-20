import Foundation

struct Task: Identifiable {    
    var id: String
    var title: String
    var description: String
    var deadline: TimeInterval
    var progressStatus: TaskStatus
    
    init(title: String, description: String, deadline: Date) {
        self.id = UUID().uuidString
        self.title = title
        self.description = description
        self.deadline = deadline.timeIntervalSince1970
        self.progressStatus = .todo
    }
    
    init(id: String, title: String, description: String, deadline: TimeInterval, progressStatus: TaskStatus) {
        self.id = id
        self.title = title
        self.description = description
        self.deadline = deadline
        self.progressStatus = progressStatus
    }
}
