import CoreData

protocol TaskUseCase {
    func create(with title: String, completed: @escaping (Bool) -> Void)
    func read(completed: @escaping ([TaskListModel]) -> Void)
    func update(taskList: TaskListModel, completed: @escaping (Bool) -> Void)
    func delete(by id: UUID, completed: @escaping (Bool) -> Void)
    func createTask(_ task: TaskModel, in taskList: TaskListModel, completed: @escaping (Bool) -> Void)
}

final class FetchTaskUseCase: TaskUseCase {
    private var repository: TaskRepository

    init(repository: TaskRepository) {
        self.repository = repository
    }

    func create(with title: String, completed: @escaping (Bool) -> Void) {
        let taskList = TaskListModel(title: title)
        repository.create(taskList: taskList, completed: completed)
    }

    func read(completed: @escaping ([TaskListModel]) -> Void) {
        repository.read(completed: completed)
    }

    func update(taskList: TaskListModel, completed: @escaping (Bool) -> Void) {
        let taskList = TaskListModel(title: taskList.title,
                                      id: taskList.id,
                                      items: taskList.items)
        repository.update(taskList: taskList, completed: completed)
    }

    func delete(by id: UUID, completed: @escaping (Bool) -> Void) {
        repository.delete(by: id, completed: completed)
    }

    func createTask(_ task: TaskModel, in taskList: TaskListModel, completed: @escaping (Bool) -> Void) {
        var taskList = taskList
        taskList.items.append(task)
        update(taskList: taskList, completed: completed)
    }
}
