import Foundation

protocol TaskUseCase {
    func create(with title: String, completed: @escaping (Bool) -> Void)
    func read(completed: @escaping ([TaskListEntity]) -> Void)
    func update(taskList: TaskListEntity, completed: @escaping (Bool) -> Void)
    func delete(by id: UUID, completed: @escaping (Bool) -> Void)
    func createTask(_ task: TaskEntity, in taskList: TaskListEntity, completed: @escaping (Bool) -> Void)
    func updateTask(_ task: TaskEntity, in taskList: TaskListEntity, completed: @escaping (Bool) -> Void)
}

final class FetchTaskUseCase: TaskUseCase {
    private var repository: TaskRepository

    init(repository: TaskRepository) {
        self.repository = repository
    }

    func create(with title: String, completed: @escaping (Bool) -> Void) {}

    func read(completed: @escaping ([TaskListEntity]) -> Void) {}

    func update(taskList: TaskListEntity, completed: @escaping (Bool) -> Void) {}

    func delete(by id: UUID, completed: @escaping (Bool) -> Void) {}

    func createTask(_ task: TaskEntity, in taskList: TaskListEntity, completed: @escaping (Bool) -> Void) {}

    func updateTask(_ task: TaskEntity, in taskList: TaskListEntity, completed: @escaping (Bool) -> Void) {}
}
