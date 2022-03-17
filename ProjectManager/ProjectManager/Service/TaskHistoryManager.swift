import Foundation

class TaskHistoryManager {
    var taskHistory = [String]()
    
    enum TaskHandleType {
        case create(title: String)
        case move(title: String, prevStatus: Task.ProgressStatus, nextStatus: Task.ProgressStatus)
        case delete(title: String, status: Task.ProgressStatus)
    }
    
    func appendHistory(taskHandleType: TaskHandleType) {
        switch taskHandleType {
        case .create(let title):
            self.taskHistory.append("create: `\(title)`")
        case .move(let title, let prevStatus, let nextStatus):
            self.taskHistory.append("create: `\(title)` from \(prevStatus) to \(nextStatus)")
        case .delete(let title, let status):
            self.taskHistory.append("create: `\(title)` from \(status)")
        }
    }
}
