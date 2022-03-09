import Foundation
import Combine

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
    
    func updateState(_ state: ProgressStatus, to task: Task) {
        manager.updateTaskState(to: task, from: state)
        reload()
    }
    
    func updateTask(_ task: Task, title: String, description: String, deadline: Date) {
        manager.updateTask(task, title: title, description: description, deadline: deadline)
        reload()
    }
    
    func deleteTask(_ id: UUID) {
        manager.deleteTask(id)
        reload()
    }
}
