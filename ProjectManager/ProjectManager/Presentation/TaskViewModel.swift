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

    func countTaskList() -> Int
    func didLoaded()

    func create(with title: String)
    func update(taskList: TaskListEntity)
    func delete(by id: UUID)
    func createTask(_ task: TaskEntity, in taskList: String)
}

final class TaskViewModel: TaskViewModelable {
    private var useCase: TaskUseCase
    lazy var taskLists: [TaskList] = [
        TaskList(title: "test",
                 items: [Task(title: "task title",
                              dueDate: formatDate(Date()),
                              lastModifiedDate: formatDate(Date()))])
    ]

    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("yyyy MM dd")
        formatter.locale = NSLocale.current
        return formatter
    }()

    init(useCase: TaskUseCase) {
        self.useCase = useCase
        didLoaded()
    }

    func formatDate(_ date: Date) -> String {
        return formatter.string(from: date)
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
