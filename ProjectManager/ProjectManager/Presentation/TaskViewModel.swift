import Foundation

protocol TaskViewModelable {
    var taskLists: [TaskList] { get set }

    func countOfTaskList() -> Int
    func fetchTaskList(at index: Int) -> TaskList
    func reloadTaskList()

    func addNewTaskList(with title: String)
    func updateTaskList(_ taskList: TaskListEntity)
    func deleteTaskList(by id: UUID)
    func createTask(_ task: TaskEntity, in taskList: String)
}

final class TaskViewModel: TaskViewModelable {
    private var useCase: TaskUseCase
    var taskLists: [TaskList] = []

    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("yyyy MM dd")
        formatter.locale = NSLocale.current
        return formatter
    }()

    init(useCase: TaskUseCase) {
        self.useCase = useCase
        self.reloadTaskList()
    }

    func formatDate(_ date: Date) -> String {
        return formatter.string(from: date)
    }

    func countOfTaskList() -> Int {
        return taskLists.count
    }

    func fetchTaskList(at index: Int) -> TaskList {
        return taskLists[index]
    }

    func fetchTask(at index: Int, in listTitle: String) -> Task? {
        guard let listIndex = taskLists.firstIndex(where: { $0.title == listTitle }) else { return nil }
        return taskLists[listIndex].items[index]
    }

    func reloadTaskList() {
        updateList()
    }

    private func updateList() {}

    func addNewTaskList(with title: String) {
        useCase.create(with: title) { [weak self] success in
            guard success else { return }
            self?.updateList()
        }
    }

    func updateTaskList(_ taskList: TaskListEntity) {
        useCase.update(taskList: taskList) { [weak self] success in
            guard success else { return }
            self?.updateList()
        }
    }

    func deleteTaskList(by id: UUID) {
        useCase.delete(by: id) { [weak self] success in
            guard success else { return }
            self?.updateList()
        }
    }

    func createTask(_ task: TaskEntity, in taskList: String) {}
}
