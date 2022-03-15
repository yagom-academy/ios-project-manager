import UIKit
import RxSwift
import RxCocoa

protocol TaskListViewModelProtocol {
    var todoTasksObservable: BehaviorSubject<[Task]>? { get }
    var doingTasksObservable: BehaviorSubject<[Task]>? { get }
    var doneTasksObservable: BehaviorSubject<[Task]>? { get }
    
    func create(task: Task)
    func delete(task: Task)
    func update(task: Task, to newTask: Task)
    
    func numberOfRowsInSection(for tableView: TaskTableView) -> Int
    func titleForHeaderInSection(for tableView: TaskTableView) -> String
    func edit(task: Task, newTitle: String, newBody: String, newDueDate: Date)
    func edit(task: Task, newProcessStatus: ProcessStatus)
}

// TODO: MVVM - Input/Output 구분
final class TaskListViewModel: TaskListViewModelProtocol {
    // MARK: - Properties
    private let taskRepository: TaskRepositoryProtocol?
    let todoTasksObservable: BehaviorSubject<[Task]>?
    let doingTasksObservable: BehaviorSubject<[Task]>?
    let doneTasksObservable: BehaviorSubject<[Task]>?
    
    // MARK: - Initializers
    init(taskRepository: TaskRepositoryProtocol = TaskRepository()) {
        self.taskRepository = taskRepository
        self.todoTasksObservable = BehaviorSubject<[Task]>(value: taskRepository.todoTasks)
        self.doingTasksObservable = BehaviorSubject<[Task]>(value: taskRepository.doingTasks)
        self.doneTasksObservable = BehaviorSubject<[Task]>(value: taskRepository.doneTasks)
    }
    
    // MARK: - Methods
    func create(task: Task) {
        taskRepository?.create(task: task)
        
        switch task.processStatus {
        case .todo:
            todoTasksObservable?.onNext(taskRepository!.todoTasks)
        case .doing:
            doingTasksObservable?.onNext(taskRepository!.doingTasks)
        case .done:
            doneTasksObservable?.onNext(taskRepository!.doneTasks)
        }
    }
    
    func delete(task: Task) {
        taskRepository?.delete(task: task)
        
        switch task.processStatus {
        case .todo:
            todoTasksObservable?.onNext(taskRepository!.todoTasks)
        case .doing:
            doingTasksObservable?.onNext(taskRepository!.doingTasks)
        case .done:
            doneTasksObservable?.onNext(taskRepository!.doneTasks)
        }
    }
    
    func update(task: Task, to newTask: Task) {
        guard task != newTask else {
            print(TaskManagerError.updateNotFound.description)
            return
        }
        
        taskRepository?.update(task: task, to: newTask)
        
        switch task.processStatus {
        case .todo:
            todoTasksObservable?.onNext(taskRepository!.todoTasks)
        case .doing:
            doingTasksObservable?.onNext(taskRepository!.doingTasks)
        case .done:
            doneTasksObservable?.onNext(taskRepository!.doneTasks)
        }
        
        guard task.processStatus != newTask.processStatus else {
            print(TaskManagerError.unchangedProcessStatus)
            return
        }
        
        switch newTask.processStatus {
        case .todo:
            todoTasksObservable?.onNext(taskRepository!.todoTasks)
        case .doing:
            doingTasksObservable?.onNext(taskRepository!.doingTasks)
        case .done:
            doneTasksObservable?.onNext(taskRepository!.doneTasks)
        }
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
    
    func titleForHeaderInSection(for tableView: TaskTableView) -> String {
        switch tableView.processStatus {
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
            return "\(ProcessStatus.doing.description) \(taskCount)"
        case .done:
            guard let taskCount = doneTasksObservable?.value.count else {
                print(TaskManagerError.taskNotFound)
                return ""
            }
            return "\(ProcessStatus.done.description) \(taskCount)"
        case .none:
            print(TableViewError.invalidTableView)
            return ""
        }
    }
    
    // MARK: - TaskEditView
    // TODO: Popover에서 Title/Body/DueData Edit 기능 구현
    func edit(task: Task, newTitle: String, newBody: String, newDueDate: Date) {
        let newTask = Task(id: task.id, title: newTitle, body: newBody, dueDate: newDueDate, processStatus: task.processStatus)
        update(task: task, to: newTask)
        
        taskRepository?.update(task: task, to: newTask)
    }
    
    // TODO: Popover에서 ProcessStatus Edit 기능 구현
    func edit(task: Task, newProcessStatus: ProcessStatus) {
        guard task.processStatus != newProcessStatus else {
            print(TaskManagerError.unchangedProcessStatus)
            return
        }
        
        let newTask = Task(id: task.id, title: task.title, body: task.body, dueDate: task.dueDate, processStatus: newProcessStatus)
        update(task: task, to: newTask)
        
        taskRepository?.update(task: task, to: newTask)
    }
}
