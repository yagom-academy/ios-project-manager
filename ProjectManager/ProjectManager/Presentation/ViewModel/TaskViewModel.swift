import Foundation

protocol TaskViewModel: TaskCellViewModel {
    func countOfTaskList() -> Int
    func titleOfTaskList(by index: Int) -> String

    func loadTaskList()
    func didChangeData(updatedData: [TaskListModel])

    func addNewTaskList(with title: String)
    func updateTaskList(_ taskList: TaskList)
    func deleteTaskList(by id: String)

    func addNewTask(title: String, dueDate: String, body: String, in taskListIndex: Int)
    func updateTask(_ task: Task, in taskListIndex: Int)
    func deleteTask(taskID: String, in taskListIndex: Int)
}

extension TaskViewModel {
    func countOfTaskList() -> Int { taskLists.count }

    func titleOfTaskList(by index: Int) -> String { taskLists[safe: index]?.title ?? "" }

    func loadTaskList() {
        repository.read { [weak self] allTaskList in
            guard let self = self else { return }
            let convertedTaskList = self.convertToTaskList(from: allTaskList)
            self.taskLists = convertedTaskList
        }
    }

    func didChangeData(updatedData: [TaskListModel]) {
        self.taskLists = convertToTaskList(from: updatedData)
        self.observer?.updated()
    }

    func addNewTaskList(with title: String) {
        let newTaskListModel = TaskListModel(title: title, creationDate: Date())
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

    func addNewTask(title: String, dueDate: String, body: String, in taskListIndex: Int) {
        guard var taskList = fetchTaskList(by: searchTaskListID(by: taskListIndex)) else { return }
        let task = Task(title: title, body: body, dueDate: dueDate)
        taskList.items.append(task)
        updateTaskList(taskList)
    }

    func updateTask(_ task: Task, in taskListIndex: Int) {
        guard var taskList = fetchTaskList(by: searchTaskListID(by: taskListIndex)) else { return }
        if let index = taskList.items.firstIndex(where: { $0.id == task.id }) {
            taskList.items[index] = task
        }
        updateTaskList(taskList)
    }

    func deleteTask(taskID: String, in taskListIndex: Int) {
        guard var taskList = fetchTaskList(by: searchTaskListID(by: taskListIndex)) else { return }
        if let index = taskList.items.firstIndex(where: { $0.id == taskID }) {
            taskList.items.remove(at: index)
        }
        updateTaskList(taskList)
    }
}
