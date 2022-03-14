import Foundation
import Combine

protocol TaskManagable {
    var taskList: [Task] { get set }
    
    func taskList(at status: Task.ProgressStatus) -> [Task]
    func createTask(_ task: Task) -> AnyPublisher<Void, Error>
    func updateTaskState(id: String, progressStatus: Task.ProgressStatus)
    func updateTask(id: String, title: String, description: String, deadline: Date)
    func deleteTask(_ id: String)
}
