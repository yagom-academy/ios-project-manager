import UIKit
import RxSwift
import RxCocoa

protocol TaskListViewModelProtocol {
    var todoTasks: BehaviorSubject<[Task]> { get }
    var doingTasks: BehaviorSubject<[Task]> { get }
    var doneTasks: BehaviorSubject<[Task]> { get }
    var entireTasks: [BehaviorSubject<[Task]>] { get }
    var todoTasksCount: Observable<Int> { get }
    var doingTasksCount: Observable<Int> { get }
    var doneTasksCount: Observable<Int> { get }
    
    func create(task: Task)
    func delete(task: Task)
    func update(task: Task, to newTask: Task)
    
    func processStatusChangeOptions(of currentProcessStatus: ProcessStatus) -> [ProcessStatus]
    func title(of changeOptions: [ProcessStatus]) -> [String]
    func edit(task: Task, newProcessStatus: ProcessStatus)
    func edit(task: Task, newTitle: String, newBody: String, newDueDate: Date)
    func createViewControllerForTaskAdd() -> UIViewController
    func createViewControllerForSelectedRow(at row: Int, inTableViewOf: ProcessStatus) -> UIViewController
    func didSwipeDeleteAction(for row: Int, inTableViewOf: ProcessStatus)
}

// TODO: MVVM - Input/Output 구분
final class TaskListViewModel: TaskListViewModelProtocol {
    // MARK: - Properties
    private let taskRepository: TaskRepositoryProtocol
    let todoTasks: BehaviorSubject<[Task]>
    let doingTasks: BehaviorSubject<[Task]>
    let doneTasks: BehaviorSubject<[Task]>
    lazy var entireTasks = [todoTasks, doingTasks, doneTasks]
    
    lazy var todoTasksCount: Observable<Int> = todoTasks.asObservable().map { $0.count }
    lazy var doingTasksCount: Observable<Int> = doingTasks.asObservable().map { $0.count }
    lazy var doneTasksCount: Observable<Int> = doneTasks.asObservable().map { $0.count }
    
    // MARK: - Initializers
    init(taskRepository: TaskRepositoryProtocol = TaskRepository()) {
        self.taskRepository = taskRepository
        self.todoTasks = BehaviorSubject<[Task]>(value: taskRepository.todoTasks)
        self.doingTasks = BehaviorSubject<[Task]>(value: taskRepository.doingTasks)
        self.doneTasks = BehaviorSubject<[Task]>(value: taskRepository.doneTasks)
    }
    
    // MARK: - Methods
    func create(task: Task) {
        taskRepository.create(task: task)
        
        switch task.processStatus {
        case .todo:
            todoTasks.onNext(taskRepository.todoTasks)
        case .doing:
            doingTasks.onNext(taskRepository.doingTasks)
        case .done:
            doneTasks.onNext(taskRepository.doneTasks)
        }
    }
    
    func delete(task: Task) {
        taskRepository.delete(task: task)
        
        switch task.processStatus {
        case .todo:
            todoTasks.onNext(taskRepository.todoTasks)
        case .doing:
            doingTasks.onNext(taskRepository.doingTasks)
        case .done:
            doneTasks.onNext(taskRepository.doneTasks)
        }
    }
    
    func update(task: Task, to newTask: Task) {
        guard task != newTask else {
            print(TaskManagerError.updateNotFound.description)
            return
        }
        
        taskRepository.update(task: task, to: newTask)
        
        switch task.processStatus {
        case .todo:
            todoTasks.onNext(taskRepository.todoTasks)
        case .doing:
            doingTasks.onNext(taskRepository.doingTasks)
        case .done:
            doneTasks.onNext(taskRepository.doneTasks)
        }
        
        guard task.processStatus != newTask.processStatus else {
            return
        }
        
        switch newTask.processStatus {
        case .todo:
            todoTasks.onNext(taskRepository.todoTasks)
        case .doing:
            doingTasks.onNext(taskRepository.doingTasks)
        case .done:
            doneTasks.onNext(taskRepository.doneTasks)
        }
    }
    
    // MARK: - Popover
    func processStatusChangeOptions(of currentProcessStatus: ProcessStatus) -> [ProcessStatus] {
        return ProcessStatus.allCases.filter { $0 != currentProcessStatus }
    }
    
    func title(of changeOptions: [ProcessStatus]) -> [String] {
        return changeOptions.map { "Move To \($0.description)"  }
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
    
    func createViewControllerForTaskAdd() -> UIViewController {
        let taskDetailViewModel = TaskDetailViewModel()
        let taskDetailController = ViewControllerFactory.createViewController(of: .newTaskDetail(taskListViewModel: self, taskDetailViewModel: taskDetailViewModel))
        taskDetailController.modalPresentationStyle = .popover
        
        return taskDetailController
    }
 
    // MARK: - TableView Delegate
    func createViewControllerForSelectedRow(at row: Int, inTableViewOf: ProcessStatus) -> UIViewController {
        var taskToEdit: Task!
        switch inTableViewOf {
        case .todo:
            taskToEdit = taskRepository.todoTasks[row]
        case .doing:
            taskToEdit = taskRepository.doingTasks[row]
        case .done:
            taskToEdit = taskRepository.doneTasks[row]
        }
        
        let taskDetailViewModel = TaskDetailViewModel()
        let taskDetailController = ViewControllerFactory.createViewController(of: .editTaskDetail(taskListViewModel: self, taskDetailViewModel: taskDetailViewModel, taskToEdit: taskToEdit))
        taskDetailController.modalPresentationStyle = .popover
        
        return taskDetailController
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
