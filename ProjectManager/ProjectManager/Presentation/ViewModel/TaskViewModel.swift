
import Foundation

protocol TaskViewModel {
    var onUpdated: () -> Void { get set }

    var taskLists: [TaskList] { get set }
    var countOfTaskList: Int { get }

    func fetchTaskList(at index: Int) -> TaskList?
    func fetchTaskList(by listName: String) -> TaskList?
    func fetchTask(at index: Int, in listTitle: String) -> Task?

    func reloadTaskList()
    func addNewTaskList(with title: String)
    func updateTaskList(_ taskList: TaskList)
    func deleteTaskList(by id: String)

    func createTask(_ task: Task, in taskList: TaskList)

}
