import UIKit

protocol TaskListViewModelProtocol {
    var todoTasksObservable: MockObservable<[Task]>? { get }
    var doingTasksObservable: MockObservable<[Task]>? { get }
    var doneTasksObservable: MockObservable<[Task]>? { get }
    
    func create(task: Task)
    func delete(task: Task)
    func update(task: Task, to newTask: Task)
    
    func numberOfRowsInSection(for tableView: TaskTableView) -> Int
    func titleForHeaderInSection(forTableOf processStatus: ProcessStatus) -> String
    func edit(task: Task, newTitle: String, newBody: String, newDueDate: Date)
    func edit(task: Task, newProcessStatus: ProcessStatus)
}

final class TaskListViewModel: TaskListViewModelProtocol {
    // MARK: - Properties
    private let taskRepository: TaskRepositoryProtocol?
    let todoTasksObservable: MockObservable<[Task]>?
    let doingTasksObservable: MockObservable<[Task]>?
    let doneTasksObservable: MockObservable<[Task]>?
    
    // MARK: - Initializers
    init(taskRepository: TaskRepositoryProtocol = TaskRepository()) {
        self.taskRepository = taskRepository
        self.todoTasksObservable = MockObservable<[Task]>(taskRepository.todoTasks)
        self.doingTasksObservable = MockObservable<[Task]>(taskRepository.doingTasks)
        self.doneTasksObservable = MockObservable<[Task]>(taskRepository.doneTasks)
    }
    
    // MARK: - Methods
    func create(task: Task) {
        switch task.processStatus {
        case .todo:
            todoTasksObservable?.value.append(task)
        case .doing:
            doingTasksObservable?.value.append(task)
        case .done:
            doneTasksObservable?.value.append(task)
        }
        
        taskRepository?.create(task: task)
    }
    
    func delete(task: Task) {
        switch task.processStatus {
        case .todo:
            guard let index = todoTasksObservable?.value.firstIndex(where: { $0.id == task.id }) else {
                print(TaskManagerError.taskNotFound)
                return
            }
            todoTasksObservable?.value.remove(at: index)
        case .doing:
            guard let index = doingTasksObservable?.value.firstIndex(where: { $0.id == task.id }) else {
                print(TaskManagerError.taskNotFound)
                return
            }
            doingTasksObservable?.value.remove(at: index)
        case .done:
            guard let index = doneTasksObservable?.value.firstIndex(where: { $0.id == task.id }) else {
                print(TaskManagerError.taskNotFound)
                return
            }
            doneTasksObservable?.value.remove(at: index)
        }
        
        taskRepository?.delete(task: task)
    }
    
    func update(task: Task, to newTask: Task) {
        delete(task: task)
        create(task: newTask)
        
        taskRepository?.update(task: task, to: newTask)
    }
    
    // MARK: - TaskListView
    func numberOfRowsInSection(for tableView: TaskTableView) -> Int {
        switch tableView.processStatus {
        case .todo:
            return todoTasksObservable?.value.count ?? 0
        case .doing:
            return doingTasksObservable?.value.count ?? 0
        case .done:
            return doneTasksObservable?.value.count ?? 0
        default:
            print(TableViewError.invalidTableView)
            return 0
        }
    }
    
    func titleForHeaderInSection(forTableOf processStatus: ProcessStatus) -> String {
        switch processStatus {
        case .todo:
            guard let taskCount = todoTasksObservable?.value.count else {
                print(TaskManagerError.taskNotFound)
                return ""
            }
            return "\(ProcessStatus.todo.description) \(taskCount)"
        case .doing:
            guard let taskCount = doingTasksObservable?.value.count else {
                print(TaskManagerError.taskNotFound)
                return ""
            }
            return "\(ProcessStatus.todo.description) \(taskCount)"
        case .done:
            guard let taskCount = doneTasksObservable?.value.count else {
                print(TaskManagerError.taskNotFound)
                return ""
            }
            return "\(ProcessStatus.todo.description) \(taskCount)"
        }
    }
    
    // MARK: - TaskEditView
    // TODO: Popover에서 Title/Body/DueData Edit 기능 구현
    func edit(task: Task, newTitle: String, newBody: String, newDueDate: Date) {
        let newTask = Task(title: newTitle, body: newBody, dueDate: newDueDate, processStatus: task.processStatus)
        update(task: task, to: newTask)
        
        taskRepository?.update(task: task, to: newTask)
    }
    
    // TODO: Popover에서 ProcessStatus Edit 기능 구현
    func edit(task: Task, newProcessStatus: ProcessStatus) {
        guard task.processStatus != newProcessStatus else {
            print(TaskManagerError.unchangedProcessStatus)
            return
        }
        
        let newTask = Task(title: task.title, body: task.body, dueDate: task.dueDate, processStatus: newProcessStatus)
        update(task: task, to: newTask)
        
        taskRepository?.update(task: task, to: newTask)
    }
}
