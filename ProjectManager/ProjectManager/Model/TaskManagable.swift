import Foundation

protocol TaskManagable {
    var taskList: [Task] { get set }
    
    func taskList(at status: ProgressStatus) -> [Task]
    func createTask(_ task: Task)
    func updateTaskState(to task: Task, from progressStatus: ProgressStatus)
    func updateTask(_ task: Task, title: String, description: String, deadline: Date)
    func deleteTask(_ id: UUID)
}
