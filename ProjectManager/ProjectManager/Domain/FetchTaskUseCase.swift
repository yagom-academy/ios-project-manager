import CoreData

protocol TaskUseCase {
    func create(with title: String, completed: @escaping (Bool) -> Void)
    func read(completed: @escaping ([TaskList]) -> Void)
    func update(taskList: TaskList, completed: @escaping (Bool) -> Void)
    func delete(by id: String, completed: @escaping (Bool) -> Void)
    func createTask(_ task: Task, in taskList: TaskList, completed: @escaping (Bool) -> Void)
}

final class FetchTaskUseCase: TaskUseCase {
    private var repository: TaskRepository

    init(repository: TaskRepository) {
        self.repository = repository
    }

    func create(with title: String, completed: @escaping (Bool) -> Void) {
        let newTaskListModel = TaskListModel(title: title)
        repository.create(taskListModel: newTaskListModel, completed: completed)
    }

    func read(completed: @escaping ([TaskList]) -> Void) {
        repository.read { entity in
            let convertedTaskList = self.convertToTaskList(from: entity)
            DispatchQueue.main.async {
                completed(convertedTaskList)
            }
        }
    }

    func update(taskList: TaskList, completed: @escaping (Bool) -> Void) {
        let convertedTaskListModel = self.convertToTaskListModel(from: taskList)
        repository.update(taskListModel: convertedTaskListModel, completed: completed)
    }

    func delete(by id: String, completed: @escaping (Bool) -> Void) {
        guard let id = UUID(uuidString: id) else { return }
        repository.delete(by: id, completed: completed)
    }

    func createTask(_ task: Task, in taskList: TaskList, completed: @escaping (Bool) -> Void) {
        var taskList = taskList
        taskList.items.append(task)
        update(taskList: taskList, completed: completed)
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
