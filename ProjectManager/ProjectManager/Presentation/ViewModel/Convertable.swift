import Foundation

protocol Convertable {
    func convertToTaskList(from taskListModel: [TaskListModel]) -> [TaskList]
    func convertToTask(from taskModel: [TaskModel]) -> [Task]
    func convertToTaskListModel(from taskList: TaskList) -> TaskListModel
    func convertToTaskModel(from task: [Task]) -> [TaskModel]
}

extension Convertable {
    func convertToTaskList(from taskListModel: [TaskListModel]) -> [TaskList] {
        return taskListModel.compactMap { taskListModel in
            let taskList = TaskList(id: taskListModel.id.uuidString,
                                    title: taskListModel.title,
                                    items: self.convertToTask(from: taskListModel.items),
                                    creationDate: taskListModel.creationDate)
            return taskList
        }
    }

    func convertToTask(from taskModel: [TaskModel]) -> [Task] {
        return taskModel.compactMap { taskModel in
            let task = Task(id: taskModel.id.uuidString,
                            title: taskModel.title,
                            body: taskModel.body,
                            dueDate: taskModel.dueDate.formatToString(),
                            creationDate: taskModel.creationDate)
            return task
        }
    }

    func convertToTaskListModel(from taskList: TaskList) -> TaskListModel {
        return TaskListModel(id: UUID(uuidString: taskList.id) ?? UUID(),
                             title: taskList.title,
                             items: self.convertToTaskModel(from: taskList.items),
                             lastModifiedDate: Date(),
                             creationDate: taskList.creationDate)
    }

    func convertToTaskModel(from task: [Task]) -> [TaskModel] {
        return task.compactMap { task in
            let taskModel = TaskModel(id: UUID(uuidString: task.id) ?? UUID(),
                                      title: task.title,
                                      body: task.body,
                                      dueDate: task.dueDate.formatToDate(),
                                      lastModifiedDate: Date(),
                                      creationDate: task.creationDate)
            return taskModel
        }
    }
}
