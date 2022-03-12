import Foundation

protocol TaskRepository {
    func saveContext()

    func create(taskList: TaskListEntity, completed: @escaping (Bool) -> Void)
    func read(completed: @escaping ([TaskListEntity]) -> Void)
    func update(taskList: TaskListEntity, completed: @escaping (Bool) -> Void)
    func delete(by id: UUID, completed: @escaping (Bool) -> Void)
}

class TaskDataRepository: TaskRepository {
    func saveContext() {
        <#code#>
    }

    func create(taskList: TaskListEntity, completed: @escaping (Bool) -> Void) { }

    func read(completed: @escaping ([TaskListEntity]) -> Void) { }

    func update(taskList: TaskListEntity, completed: @escaping (Bool) -> Void) { }

    func delete(by id: UUID, completed: @escaping (Bool) -> Void) { }
}
