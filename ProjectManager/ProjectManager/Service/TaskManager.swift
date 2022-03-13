import Foundation

class TaskManager: TaskManagable {
    var taskList = [Task]()
    
    func taskList(at status: Task.ProgressStatus) -> [Task] {
        return taskList.filter { $0.progressStatus == status }
    }
    
    func createTask(_ task: Task) {
        taskList.append(task)
    }
    
    func updateTaskState(id: UUID, progressStatus: Task.ProgressStatus) {
        taskList
            .indices
            .filter { taskList[$0].id == id }
            .forEach {
                taskList[$0].progressStatus = progressStatus
            }
    }
    
    func updateTask(id: UUID, title: String, description: String, deadline: Date) {
        taskList
            .indices
            .filter { taskList[$0].id == id }
            .forEach {
                taskList[$0].title = title
                taskList[$0].description = description
                taskList[$0].deadline = deadline.timeIntervalSince1970
            }
    }
    
    func deleteTask(_ id: UUID) {
        taskList
            .indices
            .filter { taskList[$0].id == id }
            .forEach { taskList.remove(at: $0) }
    }
}
