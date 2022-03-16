import UIKit
import RxSwift
import RxCocoa

protocol TaskListViewModelProtocol {
    var todoTasksObservable: BehaviorSubject<[Task]>? { get }
    var doingTasksObservable: BehaviorSubject<[Task]>? { get }
    var doneTasksObservable: BehaviorSubject<[Task]>? { get }
    var tasksObservables: [BehaviorSubject<[Task]>?] { get }
    
    var todoTasksCount: Observable<Int> { get }
    var doingTasksCount: Observable<Int> { get }
    var doneTasksCount: Observable<Int> { get }
    
    func create(task: Task)
    func delete(task: Task)
    func update(task: Task, to newTask: Task)
    
    func edit(task: Task, newTitle: String, newBody: String, newDueDate: Date)
    func edit(task: Task, newProcessStatus: ProcessStatus)
    func didSelectRow(at row: Int, inTableViewOf: ProcessStatus) -> UIViewController
}

// TODO: MVVM - Input/Output 구분
final class TaskListViewModel: TaskListViewModelProtocol {
    // MARK: - Properties
    private let taskRepository: TaskRepositoryProtocol?
    let todoTasksObservable: BehaviorSubject<[Task]>?
    let doingTasksObservable: BehaviorSubject<[Task]>?
    let doneTasksObservable: BehaviorSubject<[Task]>?
    lazy var tasksObservables = [todoTasksObservable, doingTasksObservable, doneTasksObservable]
    
    lazy var todoTasksCount: Observable<Int> = todoTasksObservable!.map {
        $0.count
    }
    lazy var doingTasksCount: Observable<Int> = doingTasksObservable!.map {
        $0.count
    }
    lazy var doneTasksCount: Observable<Int> = doneTasksObservable!.map {
        $0.count
    }
    
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
    
    // MARK: - TaskDetailView
    func edit(task: Task, newTitle: String, newBody: String, newDueDate: Date) {
        let newTask = Task(id: task.id, title: newTitle, body: newBody, dueDate: newDueDate, processStatus: task.processStatus)
        update(task: task, to: newTask)
    }
    
    // MARK: - Popover
    func edit(task: Task, newProcessStatus: ProcessStatus) {
        guard task.processStatus != newProcessStatus else {
            print(TaskManagerError.unchangedProcessStatus)
            return
        }
        
        let newTask = Task(id: task.id, title: task.title, body: task.body, dueDate: task.dueDate, processStatus: newProcessStatus)
        update(task: task, to: newTask)
    }
    
    func didSelectRow(at row: Int, inTableViewOf: ProcessStatus) -> UIViewController {
        var taskToEdit: Task!
        switch inTableViewOf {
        case .todo:
            taskToEdit = taskRepository?.todoTasks[row]
        case .doing:
            taskToEdit = taskRepository?.doingTasks[row]
        case .done:
            taskToEdit = taskRepository?.todoTasks[row]
        }
        
        let taskDetailController = ViewControllerFactory.createViewController(of: .editTaskDetail(viewModel: self,
                                                                                                  taskToEdit: taskToEdit))
        taskDetailController.modalPresentationStyle = .popover
        
        return taskDetailController
    }
}
