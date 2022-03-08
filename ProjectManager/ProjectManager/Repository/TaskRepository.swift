import Foundation

protocol TaskRepositoryProtocol {
    var todoTasks: [Task] { get }
    var doingTasks: [Task] { get }
    var doneTasks: [Task] { get }
}

final class TaskRepository: TaskRepositoryProtocol {
    let todoTasks: [Task] = []
    let doingTasks: [Task] = []
    let doneTasks: [Task] = []
}
