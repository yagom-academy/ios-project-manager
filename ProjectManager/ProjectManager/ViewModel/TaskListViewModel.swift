import Foundation

class TaskListViewModel: ObservableObject {
    @Published var todoTaskList = [Task]()
    @Published var doingTaskList = [Task]()
    @Published var doneTaskList = [Task]()
    
    let manager = TaskManager()

    func reload() {
        todoTaskList = manager.taskList(at: .todo)
        doingTaskList = manager.taskList(at: .doing)
        doneTaskList = manager.taskList(at: .done)
    }
    
    func createTask(_ task: Task) {
        manager.createTask(task)
        todoTaskList = manager.taskList(at: .todo)
    }
    
    func updateState(id: UUID, progressStatus: Task.ProgressStatus) {
        manager.updateTaskState(id: id, progressStatus: progressStatus)
        reload()
    }
    
    func updateTask(id: UUID, title: String, description: String, deadline: Date) {
        manager.updateTask(id: id, title: title, description: description, deadline: deadline)
        reload()
    }
    
    func deleteTask(_ task: Task) {
        manager.deleteTask(task.id)
        reload()
    }
    
    func changeableStatusList(from status: Task.ProgressStatus) -> [Task.ProgressStatus] {
        return Task.ProgressStatus.allCases.filter { $0 != status }
    }
}
