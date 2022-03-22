import Foundation

// TODO: Local/Remote BD 구현 시 활용
protocol StorageProtocol {
    func fetchAll() -> [Task]
    func create(task: Task)
    func delete(task: Task)
    func update(task: Task, to newTask: Task)
}
