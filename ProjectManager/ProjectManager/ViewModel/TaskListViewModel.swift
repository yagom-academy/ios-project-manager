import Foundation

class TaskListViewModel: ObservableObject {
    @Published var todoTaskList = [Task]()
    @Published var doingTaskList = [Task]()
    @Published var doneTaskList = [Task]()
    
    let manager = TaskManager()

    init () {
        fetch()
    }
    
    func fetch() {
        manager.fetch { _ in
            self.todoTaskList = self.manager.taskList(at: .todo)
            self.doingTaskList = self.manager.taskList(at: .doing)
            self.doneTaskList = self.manager.taskList(at: .done)
        }
    }
    
    func reload() {
        self.todoTaskList = self.manager.taskList(at: .todo)
        self.doingTaskList = self.manager.taskList(at: .doing)
        self.doneTaskList = self.manager.taskList(at: .done)
    }
    
    func createTask(_ task: Task) {
        manager.createTask(task)
        todoTaskList = manager.taskList(at: .todo)
    }
    
    func updateState(id: String, progressStatus: Task.ProgressStatus) {
        manager.updateTaskState(id: id, progressStatus: progressStatus)
        reload()
    }
    
    func updateTask(id: String, title: String, description: String, deadline: Date) {
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
