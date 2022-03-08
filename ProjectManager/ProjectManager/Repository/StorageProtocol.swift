import Foundation

// TODO: Local/Remote BD 구현 시 활용
protocol StorageProtocol {
    func create(task: Task)
    func fetchAll() -> [Task]
    func update(task: Task, newTitle: String, newBody: String, newDueDate: Date, newProcessStatus: ProcessStatus)
    func delete(task: Task)
}
