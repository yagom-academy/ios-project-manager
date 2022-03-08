import Foundation

protocol TaskListViewModelProtocol: AnyObject {
    var todoTasksObservable: MockObservable<[Task]>! { get }
    var doingTasksObservable: MockObservable<[Task]>! { get }
    var doneTasksObservable: MockObservable<[Task]>! { get }
    
    func create(task: Task, of processStatus: ProcessStatus)
    func updateTask(of task: Task, title: String, body: String, dueDate: Date)
    func delete(task: Task, of processStatus: ProcessStatus)
    func changeProcessStatus(of task: Task, to newProcessStatus: ProcessStatus)
    
    func numberOfRowsInSection(forTableOf processStatus: ProcessStatus) -> Int
    func titleForHeaderInSection(forTableOf processStatus: ProcessStatus) -> String
}

final class TaskListViewModel: TaskListViewModelProtocol {
    // MARK: - Properties
    private let taskRepository: TaskRepositoryProtocol!
    let todoTasksObservable: MockObservable<[Task]>!
    let doingTasksObservable: MockObservable<[Task]>!
    let doneTasksObservable: MockObservable<[Task]>!
    
    // MARK: - Initializers
    init(taskRepository: TaskRepositoryProtocol = TaskRepository()) {
        self.taskRepository = taskRepository
        self.todoTasksObservable = MockObservable<[Task]>(taskRepository.todoTasks)
        self.doingTasksObservable = MockObservable<[Task]>(taskRepository.doingTasks)
        self.doneTasksObservable = MockObservable<[Task]>(taskRepository.doneTasks)
    }
    
    // MARK: - TaskListView
    func numberOfRowsInSection(forTableOf processStatus: ProcessStatus) -> Int {
        switch processStatus {
        case .todo:
            return todoTasksObservable.value.count
        case .doing:
            return doingTasksObservable.value.count
        case .done:
            return doneTasksObservable.value.count
        }
    }
    
    func titleForHeaderInSection(forTableOf processStatus: ProcessStatus) -> String {
        switch processStatus {
        case .todo:
            return "\(ProcessStatus.todo.description) \(todoTasksObservable.value.count)"
        case .doing:
            return "\(ProcessStatus.doing.description) \(doingTasksObservable.value.count)"
        case .done:
            return "\(ProcessStatus.done.description) \(doneTasksObservable.value.count)"
        }
    }
    
    // MARK: - Methods
    func create(task: Task, of processStatus: ProcessStatus) {
        switch processStatus {
        case .todo:
            todoTasksObservable.value.append(task)
        case .doing:
            doingTasksObservable.value.append(task)
        case .done:
            doneTasksObservable.value.append(task)
        }
    }
    
    func updateTask(of task: Task, title: String, body: String, dueDate: Date) {
        task.title = title
        task.body = body
        task.dueDate = dueDate
    }
    
    func delete(task: Task, of processStatus: ProcessStatus) {
        let id = task.id
        
        switch processStatus {
        case .todo:
            guard let index = todoTasksObservable.value.firstIndex(where: { $0.id == id }) else {
                print(TaskManagerError.taskNotFound)
                return
            }
            todoTasksObservable.value.remove(at: index)
        case .doing:
            guard let index = doingTasksObservable.value.firstIndex(where: { $0.id == id }) else {
                print(TaskManagerError.taskNotFound)
                return
            }
            doingTasksObservable.value.remove(at: index)
        case .done:
            guard let index = doneTasksObservable.value.firstIndex(where: { $0.id == id }) else {
                print(TaskManagerError.taskNotFound)
                return
            }
            doneTasksObservable.value.remove(at: index)
        }
    }
    
    func changeProcessStatus(of task: Task, to newProcessStatus: ProcessStatus) {
        task.processStatus = newProcessStatus
    }
}
