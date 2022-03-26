import Foundation

protocol TaskViewModelObserver {
    func updated()
}

protocol TaskCellViewModel: AnyObject, TaskRepositoryDelegate, Convertable {
    var observer: TaskViewModelObserver? { get set }
    var repository: TaskRepository { get }
    var taskLists: [TaskList] { get set }

    func fetchTaskList(at index: Int) -> TaskList?
    func fetchTaskList(by id: String) -> TaskList?
    func fetchTaskItems(in taskListIndex: Int) -> [Task]?
    func fetchTask(at index: Int, in taskListIndex: Int) -> Task?

    func searchTaskID(by index: Int, in taskListIndex: Int) -> String?
    func searchTaskListID(by index: Int) -> String
}

extension TaskCellViewModel {
    func countOfTaskItems(in taskListIndex: Int) -> Int { taskLists[taskListIndex].items.count }

    func fetchTaskList(at index: Int) -> TaskList?  {
        return taskLists[safe: index] ?? nil
    }

    func fetchTaskList(by id: String) -> TaskList? {
        guard let listIndex = taskLists.firstIndex(where: { $0.id == id }) else { return nil }
        return taskLists[listIndex]
    }

    func fetchTaskItems(in taskListIndex: Int) -> [Task]? {
        let taskList = fetchTaskList(at: taskListIndex)
        return taskList?.items
    }

    func fetchTask(at index: Int, in taskListIndex: Int) -> Task? {
        let taskListId = searchTaskListID(by: taskListIndex)
        guard let taskList = fetchTaskList(by: taskListId),
              let task = taskList.items[safe: index] else { return nil }
        return task
    }

    func searchTaskListID(by index: Int) -> String {
        return taskLists[index].id
    }

    func searchTaskID(by index: Int, in taskListIndex: Int) -> String? {
        guard let taskList = fetchTaskList(by: searchTaskListID(by: taskListIndex)) else { return nil }
        return taskList.items[index].id
    }
}
