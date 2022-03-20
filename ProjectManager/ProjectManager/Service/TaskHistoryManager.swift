import Foundation

class TaskHistoryManager {
    var taskHistory = [TaskHistory]()
    
    enum Message {
        static let add = "Added `%@`."
        static let move = "Moved `%@` from %@ to %@."
        static let delete = "Removed `%@` from %@."
    }
    
    enum TaskHandleType {
        case create(title: String)
        case move(title: String, prevStatus: TaskStatus, nextStatus: TaskStatus)
        case delete(title: String, status: TaskStatus)
    }
    
    func appendHistory(taskHandleType: TaskHandleType) {
        let date = Date().timeIntervalSince1970
        
        switch taskHandleType {
        case .create(let title):
            let description = Message.add.localized(with: [title])
            let history = TaskHistory(description: description, date: date)
            self.taskHistory.append(history)
        case .move(let title, let prevStatus, let nextStatus):
            let description = Message.move.localized(with: [title, prevStatus.name, nextStatus.name])
            let history = TaskHistory(description: description, date: date)
            self.taskHistory.append(history)
        case .delete(let title, let status):
            let description = Message.delete.localized(with: [title, status.name])
            let history = TaskHistory(description: description, date: date)
            self.taskHistory.append(history)
        }
    }
}
