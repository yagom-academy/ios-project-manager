import Foundation

protocol TaskManagable {
    var taskList: [Task] { get set }
    
    func taskList(at status: ProgressStatus) -> [Task]
    func createTask(_ task: Task)
    func updateTaskState(id: UUID, progressStatus: ProgressStatus)
    func updateTask(id: UUID, title: String, description: String, deadline: Date)
    func deleteTask(_ id: UUID)
}
