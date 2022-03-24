import UIKit
import RxSwift

protocol TaskListViewModelInputProtocol {
//    func create(task: Task) // DetailView로 분리 (TODO: UseCase별 Protocol로 구분)
    func delete(task: Task)
    func update(task: Task, to newTask: Task)
    
    func processStatusChangeOptions(of currentProcessStatus: ProcessStatus) -> [ProcessStatus]
    func title(of changeOptions: [ProcessStatus]) -> [String]
    func edit(task: Task, newProcessStatus: ProcessStatus)
//    func edit(task: Task, newTitle: String, newBody: String, newDueDate: Date) // DetailView로 분리
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
    
    func changeDateLabelColorIfExpired(with: Date) -> UIColor
}

protocol TaskListViewModelProtocol: TaskListViewModelInputProtocol, TaskListViewModelOutputProtocol { }

final class TaskListViewModel: TaskListViewModelProtocol {
    // MARK: - Properties
    let taskRepository: TaskRepositoryProtocol
    
    // Repository의 BehaviorRelay를 map으로 받아서 Observable로 만들어줌
    lazy var todoTasks: Observable<[Task]> = taskRepository.entireTasks.map { tasks in
        tasks.filter { $0.processStatus == .todo }
    }
    lazy var doingTasks: Observable<[Task]> = taskRepository.entireTasks.map { tasks in
        tasks.filter { $0.processStatus == .doing }
    }
    lazy var doneTasks: Observable<[Task]> = taskRepository.entireTasks.map { tasks in
        tasks.filter { $0.processStatus == .done }
    }
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

    func changeDateLabelColorIfExpired(with date: Date) -> UIColor {
        let dayInSeconds: Double = 3600 * 24
        let yesterday = Date(timeIntervalSinceNow: -dayInSeconds)
        return date < yesterday ? .systemRed : .label
    }

    // MARK: - Popover
    func processStatusChangeOptions(of currentProcessStatus: ProcessStatus) -> [ProcessStatus] {
        return ProcessStatus.allCases.filter { $0 != currentProcessStatus }
    }

    func title(of changeOptions: [ProcessStatus]) -> [String] {
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
    
    // MARK: - TaskDetailView
    func edit(task: Task, newTitle: String, newBody: String, newDueDate: Date) {
        let newTask = Task(id: task.id, title: newTitle, body: newBody, dueDate: newDueDate, processStatus: task.processStatus)
        update(task: task, to: newTask)
    }
    
    func didTouchUpAddButton() {
        actions?.showTaskDetailToAddTask()
    }
}
