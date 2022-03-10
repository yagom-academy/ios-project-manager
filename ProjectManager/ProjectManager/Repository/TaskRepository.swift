import Foundation

protocol TaskRepositoryProtocol {
    var entireTasks: [Task] { get }
    var todoTasks: [Task] { get }
    var doingTasks: [Task] { get }
    var doneTasks: [Task] { get }
    
    func create(task: Task)
    func delete(task: Task)
    func update(task: Task, to newTask: Task)
}

final class TaskRepository: TaskRepositoryProtocol {
    var entireTasks: [Task] = []
    
    var todoTasks: [Task] {
        return entireTasks.filter { $0.processStatus == .todo }
    }
    var doingTasks: [Task] {
        return entireTasks.filter { $0.processStatus == .doing }
    }
    var doneTasks: [Task] {
        return entireTasks.filter { $0.processStatus == .done }
    }
    
    init(entireTasks: [Task] = []) {
        self.entireTasks = entireTasks
    }
    
    func create(task: Task) {
        entireTasks.append(task)
    }
    
    func delete(task: Task) {
        guard let index = entireTasks.firstIndex(where: { $0.id == task.id }) else {
            print(TaskManagerError.taskNotFound)
            return
        }
        entireTasks.remove(at: index)
    }
    
    func update(task: Task, to newTask: Task) {
        delete(task: task)
        create(task: newTask)
    }
}
