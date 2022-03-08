import XCTest

class ProjectManagerTests: XCTestCase {
    var taskRepository: TaskRepositoryProtocol?
    var taskListViewModel: TaskListViewModelProtocol?

    override func setUpWithError() throws {
        taskRepository = TaskRepository()
        taskListViewModel = TaskListViewModel()
    }
//    func create(task: Task, of processStatus: ProcessStatus)
//    func updateTask(of task: Task, title: String, body: String, dueDate: Date)
//    func delete(task: Task, of processStatus: ProcessStatus)
//    func changeProcessStatus(of task: Task, to newProcessStatus: ProcessStatus)
//
//    func numberOfRowsInSection(forTableOf processStatus: ProcessStatus) -> Int

    override func tearDownWithError() throws {
        taskRepository = nil
        taskListViewModel = nil
    }

    func test_TaskListViewModel_새로운Task를_create하면_Task배열에_추가된다() {
        let newTask = Task(title: "1", body: "1", dueDate: Date())
    }
}
