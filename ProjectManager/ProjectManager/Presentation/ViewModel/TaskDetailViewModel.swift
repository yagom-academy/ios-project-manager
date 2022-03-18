import Foundation

final class TaskDetailViewModel: TaskViewModel {
    private var repository: TaskRepository

    init(repository: TaskRepository = TaskDataRepository()) {
        self.repository = repository
        loadTaskList()
    }

    var onUpdated: () -> Void = {}

    var taskLists: [TaskList] = []
    {
        didSet {
            onUpdated()
        }
    }

    var countOfTaskList: Int { taskLists.count }

    func fetchTaskList(at index: Int) -> TaskList? {
        return taskLists[safe: index] ?? nil
    }

    func fetchTask(at index: Int, in listTitle: String) -> Task? {
        guard let listIndex = taskLists.firstIndex(where: { $0.title == listTitle }) else { return nil }
        return taskLists[listIndex].items[safe: index]
    }

    func reloadTaskList() {
        loadTaskList()
    }

    private func loadTaskList() {
        repository.read { [weak self] allTaskList in
            guard let self = self else { return }
            let convertedTaskList = self.convertToTaskList(from: allTaskList)
            DispatchQueue.main.async {
                self.taskLists = convertedTaskList
            }
        }
    }

    func addNewTaskList(with title: String) {
        let newTaskListModel = TaskListModel(title: title)
        repository.create(taskListModel: newTaskListModel) { [weak self] success in
            guard success, let self = self else { return }
            self.loadTaskList()
        }
    }

    func updateTaskList(_ taskList: TaskList) {
        let convertedTaskListModel = self.convertToTaskListModel(from: taskList)
        repository.update(taskListModel: convertedTaskListModel) { [weak self] success in
            guard success, let self = self else { return }
            self.loadTaskList()
        }
    }

    func deleteTaskList(by id: String) {
        guard let id = UUID(uuidString: id) else { return }
        repository.delete(by: id) { [weak self] success in
            guard success, let self = self else { return }
            self.loadTaskList()
        }
    }

    func createTask(_ task: Task, in taskList: TaskList) {
        var taskList = taskList
        taskList.items.append(task)
        updateTaskList(taskList)
    }

    private func convertToTaskList(from taskListModel: [TaskListModel]) -> [TaskList] {
        return taskListModel.compactMap { taskListModel in
            let taskList = TaskList(id: taskListModel.id.uuidString,
                                    title: taskListModel.title,
                                    items: self.convertToTask(from: taskListModel.items),
                                    lastModifiedDate: taskListModel.lastModifiedDate.formatToString())
            return taskList
        }
    }

    private func convertToTask(from taskModel: [TaskModel]) -> [Task] {
        return taskModel.compactMap { taskModel in
            let task = Task(id: taskModel.id.uuidString,
                            title: taskModel.title,
                            body: taskModel.body,
                            dueDate: taskModel.dueDate.formatToString(),
                            lastModifiedDate: taskModel.lastModifiedDate.formatToString())
            return task
        }
    }

    private func convertToTaskListModel(from taskList: TaskList) -> TaskListModel {
        return TaskListModel(id: UUID(uuidString: taskList.id) ?? UUID(),
                             title: taskList.title,
                             items: self.convertToTaskModel(from: taskList.items),
                             lastModifiedDate: taskList.lastModifiedDate.formatToDate())
    }

    private func convertToTaskModel(from task: [Task]) -> [TaskModel] {
        return task.compactMap { task in
            let taskModel = TaskModel(title: task.title,
                                      id: UUID(uuidString: task.id) ?? UUID(),
                                      body: task.body,
                                      dueDate: task.dueDate.formatToDate(),
                                      lastModifiedDate: task.lastModifiedDate.formatToDate())
            return taskModel
        }
    }
}
