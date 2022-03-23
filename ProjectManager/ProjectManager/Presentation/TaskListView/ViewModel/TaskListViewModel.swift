import UIKit
import RxSwift
//import RxCocoa

protocol TaskListViewModelInputProtocol {
//    func create(task: Task) // Detail로 이동
    func delete(task: Task)
    func update(task: Task, to newTask: Task)
    
    func processStatusChangeOptions(of currentProcessStatus: ProcessStatus) -> [ProcessStatus]
    func title(of changeOptions: [ProcessStatus]) -> [String]
    func edit(task: Task, newProcessStatus: ProcessStatus)
//    func edit(task: Task, newTitle: String, newBody: String, newDueDate: Date) // Detail로 이동
    func didTouchUpAddButton()
    func didSelectTask(at row: Int, inTableViewOf: ProcessStatus)
    func didSwipeDeleteAction(for row: Int, inTableViewOf: ProcessStatus)
    func presentPopover(with alert: UIAlertController)
}

protocol TaskListViewModelOutputProtocol {
    var taskRepository: TaskRepositoryProtocol { get }
    var todoTasks: BehaviorSubject<[Task]> { get }
    var doingTasks: BehaviorSubject<[Task]> { get }
    var doneTasks: BehaviorSubject<[Task]> { get }
    var entireTasks: [BehaviorSubject<[Task]>] { get }
    var todoTasksCount: Observable<Int> { get }
    var doingTasksCount: Observable<Int> { get }
    var doneTasksCount: Observable<Int> { get }
    
    func changeDateLabelColorIfExpired(with: Date) -> UIColor
}

protocol TaskListViewModelProtocol: TaskListViewModelInputProtocol, TaskListViewModelOutputProtocol { }

final class TaskListViewModel: TaskListViewModelProtocol {
    // MARK: - Properties
    let taskRepository: TaskRepositoryProtocol
    var todoTasks: BehaviorSubject<[Task]> // 왜 let은 안되지?
    var doingTasks: BehaviorSubject<[Task]>
    var doneTasks: BehaviorSubject<[Task]>
    lazy var entireTasks = [todoTasks, doingTasks, doneTasks]
    private var disposeBag = DisposeBag()
    
    lazy var todoTasksCount: Observable<Int> = todoTasks.asObservable().map { $0.count }
    lazy var doingTasksCount: Observable<Int> = doingTasks.asObservable().map { $0.count }
    lazy var doneTasksCount: Observable<Int> = doneTasks.asObservable().map { $0.count }
    
    let actions: TaskListViewModelActions?
    
    // MARK: - Initializers
    init(taskRepository: TaskRepositoryProtocol, actions: TaskListViewModelActions) {
        self.taskRepository = taskRepository
        
        taskRepository.todoTasks
            .bind(onNext: { [weak self] tasks in
                self?.todoTasks = BehaviorSubject<[Task]>(value: tasks)
            })
            .disposed(by: disposeBag)
        
        taskRepository.doingTasks
            .bind(onNext: { [weak self] tasks in
                self?.doingTasks = BehaviorSubject<[Task]>(value: tasks)
            })
            .disposed(by: disposeBag)
        
        taskRepository.doneTasks
            .bind(onNext: { [weak self] tasks in
                self?.doneTasks = BehaviorSubject<[Task]>(value: tasks)
            })
            .disposed(by: disposeBag)

        self.actions = actions
    }
    
    // MARK: - Methods
    // DetailViewModel로 이동
//    func create(task: Task) {
//        taskRepository.create(task: task)
//        
//        switch task.processStatus {
//        case .todo:
//            todoTasks.onNext(taskRepository.todoTasks)
//        case .doing:
//            doingTasks.onNext(taskRepository.doingTasks)
//        case .done:
//            doneTasks.onNext(taskRepository.doneTasks)
//        }
//    }
    
    func delete(task: Task) {
        taskRepository.delete(task: task)

//        switch task.processStatus {
//        case .todo:
//            todoTasks.onNext(taskRepository.todoTasks) // Repository의 Task에 변동사항이 있으면 자동으로 onNext로 전달됨
//        case .doing:
//            doingTasks.onNext(taskRepository.doingTasks)
//        case .done:
//            doneTasks.onNext(taskRepository.doneTasks)
//        }
    }

    func update(task: Task, to newTask: Task) {
        guard task != newTask else {
            print(TaskManagerError.updateNotFound.description)
            return
        }

        taskRepository.update(task: task, to: newTask)

//        switch task.processStatus {
//        case .todo:
//            todoTasks.onNext(taskRepository.todoTasks)
//        case .doing:
//            doingTasks.onNext(taskRepository.doingTasks)
//        case .done:
//            doneTasks.onNext(taskRepository.doneTasks)
//        }
//
//        guard task.processStatus != newTask.processStatus else { return }
//
//        switch newTask.processStatus {
//        case .todo:
//            todoTasks.onNext(taskRepository.todoTasks)
//        case .doing:
//            doingTasks.onNext(taskRepository.doingTasks)
//        case .done:
//            doneTasks.onNext(taskRepository.doneTasks)
//        }
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
    
//     MARK: - TaskDetailView
    func edit(task: Task, newTitle: String, newBody: String, newDueDate: Date) {
        let newTask = Task(id: task.id, title: newTitle, body: newBody, dueDate: newDueDate, processStatus: task.processStatus)
        update(task: task, to: newTask)
    }
    
    func didTouchUpAddButton() {
        actions?.showTaskDetailToAddTask()
    }
 
    // MARK: - TableView Delegate
    func didSelectTask(at row: Int, inTableViewOf: ProcessStatus) {
        var taskToEdit: Task!
        switch inTableViewOf {
        case .todo:
            taskToEdit = taskRepository.todoTasks. [row]
        case .doing:
            taskToEdit = taskRepository.doingTasks[row]
        case .done:
            taskToEdit = taskRepository.doneTasks[row]
        }

        actions?.showTaskDetailToEditTask(taskToEdit)
    }

    func didSwipeDeleteAction(for row: Int, inTableViewOf: ProcessStatus) {
        var taskToDelete: Task!
        switch inTableViewOf {
        case .todo:
            taskToDelete = taskRepository.todoTasks[row]
        case .doing:
            taskToDelete = taskRepository.doingTasks[row]
        case .done:
            taskToDelete = taskRepository.doneTasks[row]
        }

        delete(task: taskToDelete)
    }
}
