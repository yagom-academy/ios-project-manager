import Foundation

class TaskManager: TaskManagable {
    let taskListRepository = TaskListRepository()
    var taskList = [Task]()
    
    func taskList(at status: Task.ProgressStatus) -> [Task] {
        return taskList.filter { $0.progressStatus == status }
    }
    
    func createTask(_ task: Task) {
        taskList.append(task)
    }
    
    func updateTaskState(id: String, progressStatus: Task.ProgressStatus) {
        taskList
            .indices
            .filter { taskList[$0].id == id }
            .forEach {
                taskList[$0].progressStatus = progressStatus
            }
    }
    
    func updateTask(id: String, title: String, description: String, deadline: Date) {
        taskList
            .indices
            .filter { taskList[$0].id == id }
            .forEach {
                taskList[$0].title = title
                taskList[$0].description = description
                taskList[$0].deadline = deadline.timeIntervalSince1970
            }
    }
    
    func deleteTask(_ id: String) {
        taskList
            .indices
            .filter { taskList[$0].id == id }
            .forEach { taskList.remove(at: $0) }
    }
    
    func fetch(complition: @escaping ([Task]) -> Void) {
        taskListRepository.read { entityTaskList in
            entityTaskList.forEach { entityTask in
                let id = entityTask.id
                let title = entityTask.title
                let description = entityTask.description
                let deadline = entityTask.deadline
                let progressStatus = Task.ProgressStatus(rawValue: entityTask.progressStatus) ?? .todo
                let task = Task(
                    id: id,
                    title: title,
                    description: description,
                    deadline: deadline,
                    progressStatus: progressStatus
                )
                self.taskList.append(task)
                complition(self.taskList)
            }
        }
    }
}
