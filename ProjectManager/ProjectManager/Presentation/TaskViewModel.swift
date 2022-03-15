import Foundation

class TaskList: Identifiable {
    var id: String
    var title: String
    var items: [Task]

    init(title: String, items: [Task] = []) {
        self.id = UUID().uuidString
        self.title = title
        self.items = items
    }
}

class Task: Identifiable {
    var id: String
    var title: String
    var body: String
    var dueDate: String
    var lastModifiedDate: String

    init(title: String, dueDate: String, lastModifiedDate: String, body: String = "") {
        self.id = UUID().uuidString
        self.title = title
        self.body = body
        self.dueDate = dueDate
        self.lastModifiedDate = lastModifiedDate
    }
}

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
    lazy var taskLists: [TaskList] = [TaskList(title: "test",
                                               items: [Task(title: "task title",
                                                            dueDate: formatDate(Date()),
                                                            lastModifiedDate: formatDate(Date()))])]

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
