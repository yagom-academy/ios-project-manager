import Foundation

protocol TaskViewModelable {
    var taskLists: [TaskListEntity] { get set }

    func countTaskList() -> Int
    func didLoaded()

    func create(with title: String)
    func update(taskList: TaskListEntity)
    func delete(by id: UUID)
    func createTask(_ task: TaskEntity, in taskList: String)
}

final class TaskViewModel: TaskViewModelable {
    private var useCase: TaskUseCase
    var taskLists: [TaskListEntity] = [
        TaskListEntity(title: "test", items: [TaskEntity(title: "task", dueDate: Date())])
        ]

    init(useCase: TaskUseCase) {
        self.useCase = useCase
        didLoaded()
    }

    func countTaskList() -> Int {
        return taskLists.count
    }

    func didLoaded() {
        updateList()
    }

    private func updateList() {
//        useCase.read { [weak self] tasks in
//            self?.taskLists = tasks
//        }
    }

    func create(with title: String) {
        useCase.create(with: title) { [weak self] success in
            guard success else { return }
            self?.updateList()
        }
    }

    func update(taskList: TaskListEntity) {
        useCase.update(taskList: taskList) { [weak self] success in
            guard success else { return }
            self?.updateList()
        }
    }

    func delete(by id: UUID) {
        useCase.delete(by: id) { [weak self] success in
            guard success else { return }
            self?.updateList()
        }
    }

    func createTask(_ task: TaskEntity, in taskList: String) {}
}
