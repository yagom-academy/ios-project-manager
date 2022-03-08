import Foundation

protocol TaskRepositoryProtocol {
    var entireTasks: [Task] { get }
    var todoTasks: [Task] { get }
    var doingTasks: [Task] { get }
    var doneTasks: [Task] { get }
    
    func create(task: Task)
    func update(task: Task, newTitle: String, newBody: String, newDueDate: Date, newProcessStatus: ProcessStatus)
    func delete(task: Task)
}

final class TaskRepository: TaskRepositoryProtocol {
    var entireTasks: [Task] = []
    
    var todoTasks: [Task] {
        return entireTasks.filter { $0.processStatus == .todo }
    }
    var doingTasks: [Task] {
        return entireTasks.filter { $0.processStatus == .todo }
    }
    var doneTasks: [Task] {
        return entireTasks.filter { $0.processStatus == .todo }
    }
    
    init(entireTasks: [Task] = []) {
        self.entireTasks = []
    }
    
    func create(task: Task) {
        entireTasks.append(task)
    }
    
    func update(task: Task, newTitle title: String, newBody body: String, newDueDate dueDate: Date, newProcessStatus processStatus: ProcessStatus) {
        guard let index = entireTasks.firstIndex(where: { $0.id == task.id }) else {
            print(TaskManagerError.taskNotFound)
            return
        }
        entireTasks[index].title = title
        entireTasks[index].body = body
        entireTasks[index].dueDate = dueDate
        entireTasks[index].processStatus = processStatus
    }
    
    func delete(task: Task) {
        guard let index = entireTasks.firstIndex(where: { $0.id == task.id }) else {
            print(TaskManagerError.taskNotFound)
            return
        }
        entireTasks.remove(at: index)
    }
}
