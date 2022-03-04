import Foundation

struct TaskDataSource {}

protocol TaskRepository {
    var dataSource: TaskDataSource { get }
    func fetchTasks() -> [TaskEntity]
}
