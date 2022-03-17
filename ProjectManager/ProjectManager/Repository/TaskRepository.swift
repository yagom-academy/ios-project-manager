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
        return entireTasks.filter { $0.processStatus == .todo }.sorted { $0.dueDate < $1.dueDate }
    }
    var doingTasks: [Task] {
        return entireTasks.filter { $0.processStatus == .doing }.sorted { $0.dueDate < $1.dueDate }
    }
    var doneTasks: [Task] {
        return entireTasks.filter { $0.processStatus == .done }.sorted { $0.dueDate < $1.dueDate }
    }
    
    init(entireTasks: [Task] = []) {
//        self.entireTasks = entireTasks
        
        // Dummy Data
        self.entireTasks = [
                            Task(title: "TODO-1", body: "Rx를 곁들인", dueDate: Date()),
                            Task(title: "TODO-2", body: "RxSwift", dueDate: Date()),
                            Task(title: "DOING-1", body: "RxCocoa", dueDate: Date(), processStatus: .doing),
                            Task(title: "DONE-1", body: "MVVM", dueDate: Date(), processStatus: .done)
                            ]
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
