import Foundation

class TaskManager {
    var taskList = [Task]()
    
    func taskList(at status: ProgressStatus) -> [Task] {
        return taskList.filter { $0.progressStatus == status }
    }
    
    func createTask(_ task: Task) {
        taskList.append(task)
    }
    
    func updateTaskState(to task: Task, from progressStatus: ProgressStatus) {
        taskList
            .indices
            .filter { taskList[$0].id == task.id }
            .forEach {
                taskList[$0].progressStatus = progressStatus
            }
    }
    
    func updateTask(_ task: Task, title: String, description: String, deadline: Date) {
        taskList
            .indices
            .filter { taskList[$0].id == task.id }
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
