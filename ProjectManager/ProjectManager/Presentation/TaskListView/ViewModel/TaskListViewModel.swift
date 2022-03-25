import UIKit
import RxSwift

protocol TaskListViewModelInputProtocol {
//    func create(task: Task) // DetailView로 분리 (TODO: UseCase별 Protocol로 구분)
    func delete(task: Task)
    func update(task: Task, to newTask: Task)
    func edit(task: Task, newProcessStatus: ProcessStatus)
//    func edit(task: Task, newTitle: String, newBody: String, newDueDate: Date) // DetailView로 분리

    func processStatusChangeOptions(of currentProcessStatus: ProcessStatus) -> [ProcessStatus]
    func popoverTitle(of changeOptions: [ProcessStatus]) -> [String]
    func didTouchUpAddButton()
    func presentPopover(with alert: UIAlertController)
}

protocol TaskListViewModelOutputProtocol {
    var taskRepository: TaskRepositoryProtocol { get }
    var todoTasks: Observable<[Task]> { get }
    var doingTasks: Observable<[Task]> { get }
    var doneTasks: Observable<[Task]> { get }
    var todoTasksCount: Observable<Int> { get }
    var doingTasksCount: Observable<Int> { get }
    var doneTasksCount: Observable<Int> { get }
    var actions: TaskListViewModelActions? { get }
    
//    func changeDateLabelColorIfExpired(with: Date) -> UIColor // TaskViewModel로 분리
}

protocol TaskListViewModelProtocol: TaskListViewModelInputProtocol, TaskListViewModelOutputProtocol { }

final class TaskListViewModel: TaskListViewModelProtocol {
    // MARK: - Properties
    let taskRepository: TaskRepositoryProtocol
    
    lazy var todoTasks: Observable<[Task]> = taskRepository.todoTasks
    lazy var doingTasks: Observable<[Task]> = taskRepository.doingTasks
    lazy var doneTasks: Observable<[Task]> = taskRepository.doneTasks
    lazy var todoTasksCount: Observable<Int> = todoTasks.asObservable().map { $0.count }
    lazy var doingTasksCount: Observable<Int> = doingTasks.asObservable().map { $0.count }
    lazy var doneTasksCount: Observable<Int> = doneTasks.asObservable().map { $0.count }
    
    let actions: TaskListViewModelActions?
    private var disposeBag = DisposeBag()
    
    // MARK: - Initializers
    init(taskRepository: TaskRepositoryProtocol, actions: TaskListViewModelActions) {
        self.taskRepository = taskRepository
        self.actions = actions
    }
    
    // MARK: - Methods
    func delete(task: Task) {
        taskRepository.delete(task: task)
    }

    func update(task: Task, to newTask: Task) {
        guard task != newTask else {
            print(TaskManagerError.updateNotFound.description)
            return
        }

        taskRepository.update(task: task, to: newTask)
    }

    // MARK: - Popover
    func processStatusChangeOptions(of currentProcessStatus: ProcessStatus) -> [ProcessStatus] {
        return ProcessStatus.allCases.filter { $0 != currentProcessStatus }
    }

    func popoverTitle(of changeOptions: [ProcessStatus]) -> [String] {
        return changeOptions.map { "Move To \($0.description)"  }
    }

    func presentPopover(with alert: UIAlertController) {
        actions?.presentPopover(alert)
    }

    func edit(task: Task, newProcessStatus: ProcessStatus) {
        guard task.processStatus != newProcessStatus else {
            print(TaskManagerError.unchangedProcessStatus)
            return
        }

        let newTask = Task(id: task.id, title: task.title, body: task.body, dueDate: task.dueDate, processStatus: newProcessStatus)
        update(task: task, to: newTask)
    }
    
    // MARK: - Add Task
    func didTouchUpAddButton() {
        actions?.showTaskDetailToAddTask()
    }
}
