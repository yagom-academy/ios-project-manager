import Foundation

class TaskHistoryManager {
    var taskHistory = [TaskHistory]()
    
    enum TaskHandleType {
        case create(title: String)
        case move(title: String, prevStatus: Task.ProgressStatus, nextStatus: Task.ProgressStatus)
        case delete(title: String, status: Task.ProgressStatus)
    }
    
    func appendHistory(taskHandleType: TaskHandleType) {
        let date = Date().timeIntervalSince1970
        
        switch taskHandleType {
        case .create(let title):
            let description = "Addd `%@`.".localized(with: title)
            let history = TaskHistory(description: description, date: date)
            self.taskHistory.append(history)
        case .move(let title, let prevStatus, let nextStatus):
            let description = "Moved `%@` from %@ to %@.".localized(with: title, prevStatus.name, nextStatus.name)
            let history = TaskHistory(description: description, date: date)
            self.taskHistory.append(history)
        case .delete(let title, let status):
            let description = "Removed `%@` from %@.".localized(with: title, status.name)
            let history = TaskHistory(description: description, date: date)
            self.taskHistory.append(history)
        }
    }
}
