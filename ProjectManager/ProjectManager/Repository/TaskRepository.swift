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
        if let index = findIndex(with: task.id) {
            entireTasks.remove(at: index)
        }
    }
    
    func update(task: Task, to newTask: Task) {
        if let index = findIndex(with: task.id) {
            let oldTaskId = task.id
            newTask.changeId(to: oldTaskId)
            entireTasks[index] = newTask
        }
    }
    
    func findIndex(with id: UUID) -> Int? {
        guard let index = entireTasks.firstIndex(where: { $0.id == id }) else {
            print(TaskManagerError.taskNotFound.description)
            return nil
        }
        
        return index
    }
}
