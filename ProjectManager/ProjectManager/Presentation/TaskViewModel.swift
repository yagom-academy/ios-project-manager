import Foundation

protocol TaskViewModelable {
    var taskLists: [TaskList] { get set }
    var countOfTaskList: Int { get }

    func reloadTaskList()

    func fetchTaskList(at index: Int) -> TaskList?
    func fetchTask(at index: Int, in listTitle: String) -> Task?

    func addNewTaskList(with title: String)
    func updateTaskList(_ taskList: TaskList)
    func deleteTaskList(by id: String)

    func createTask(_ task: Task, in taskList: String)
}

final class TaskViewModel: TaskViewModelable {
    var taskLists: [TaskList] = []
    var countOfTaskList: Int { taskLists.count }

    private var useCase: TaskUseCase

    init(useCase: TaskUseCase) {
        self.useCase = useCase
        loadTaskList()
    }

    func reloadTaskList() {
        loadTaskList()
    }

    private func loadTaskList() {
        useCase.read { [weak self] allTaskList in
            guard let self = self else { return }
            self.taskLists = allTaskList
        }
    }

    func fetchTaskList(at index: Int) -> TaskList? {
        return taskLists[safe: index] ?? nil
    }

    func fetchTask(at index: Int, in listTitle: String) -> Task? {
        guard let listIndex = taskLists.firstIndex(where: { $0.title == listTitle }) else { return nil }
        return taskLists[listIndex].items[safe: index]
    }

    func addNewTaskList(with title: String) {
        useCase.create(with: title) { [weak self] success in
            guard success, let self = self else { return }
            self.loadTaskList()
        }
    }

    func updateTaskList(_ taskList: TaskList) {
        useCase.update(taskList: taskList) { [weak self] success in
            guard success, let self = self else { return }
            self.loadTaskList()
        }
    }

    func deleteTaskList(by id: String) {
        useCase.delete(by: id) { [weak self] success in
            guard success, let self = self else { return }
            self.loadTaskList()
        }
    }

    func createTask(_ task: Task, in taskList: String) {}
}
