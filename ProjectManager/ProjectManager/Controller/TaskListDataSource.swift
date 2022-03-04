import Foundation

protocol TaskListDataSourceDelegate: AnyObject {
    
}

protocol TaskListDataSourceProtocol: AnyObject {
    var todoTasks: [Task] { get }
    var doingTasks: [Task] { get }
    var doneTasks: [Task] { get }

    func create(task: Task)
    func updateTask(of task: Task, title: String, body: String, dueDate: Date)
    func delete(task: Task)
    func changeProcessStatus(of task: Task, to newProcessStatus: ProcessStatus)
}

class TaskListDataSource: TaskListDataSourceProtocol {
    weak var delegate: TaskListDataSourceDelegate?
    
    var todoTasks: [Task] = []
    var doingTasks: [Task] = []
    var doneTasks: [Task] = []

    func create(task: Task) {
        todoTasks.append(task)
    }
    
    func updateTask(of task: Task, title: String, body: String, dueDate: Date) {
        task.title = title
        task.body = body
        task.dueDate = dueDate
    }
    
    func delete(task: Task) {
        let id = task.id
        todoTasks.removeAll { $0.id == id }
        doingTasks.removeAll { $0.id == id }
        doneTasks.removeAll { $0.id == id }
    }
    
    func changeProcessStatus(of task: Task, to newProcessStatus: ProcessStatus) {
        task.processStatus = newProcessStatus
    }
}
