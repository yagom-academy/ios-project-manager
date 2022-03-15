import UIKit
import RxSwift
import RxCocoa

protocol TaskListViewModelProtocol {
    var todoTasksObservable: BehaviorSubject<[Task]>? { get }
    var doingTasksObservable: BehaviorSubject<[Task]>? { get }
    var doneTasksObservable: BehaviorSubject<[Task]>? { get }
    var todoTasksCount: Observable<Int> { get }
    var doingTasksCount: Observable<Int> { get }
    var doneTasksCount: Observable<Int> { get }
    
    func create(task: Task)
    func delete(task: Task)
    func update(task: Task, to newTask: Task)
    
    func numberOfRowsInSection(for tableView: TaskTableView) -> Observable<Int>
    func titleForHeaderInSection(for tableView: TaskTableView) -> Observable<String>
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
    
    // MARK: - TaskListView
    func numberOfRowsInSection(for tableView: TaskTableView) -> Observable<Int> {  // Int가 아니라 Observable<Int>로 보내는게 맞겠지? 변경사항을 View에 자동 반영하려면...?
        switch tableView.processStatus {
        case .todo:
            return todoTasksCount
        case .doing:
            return doingTasksCount
        case .done:
            return doneTasksCount
        default:
            print(TableViewError.invalidTableView)
            return todoTasksCount
        }
    }
    
    func titleForHeaderInSection(for tableView: TaskTableView) -> Observable<String> {
        switch tableView.processStatus {
        case .todo:
            return todoTasksCount.map { "\(ProcessStatus.todo.description) \($0)" }
//            return "\(ProcessStatus.todo.description) \(todoTasksCount)" // Observable<Int> 타입

            //            let count = todoTasksCount.map { $0.description } // Int -> String 타입으로 꺼내줘야하나?
//            return "\(ProcessStatus.todo.description) \(count)"
        case .doing:
            return doingTasksCount.map { "\(ProcessStatus.doing.description) \($0)" }
        case .done:
            return doneTasksCount.map { "\(ProcessStatus.done.description) \($0)" }
        case .none:
            print(TableViewError.invalidTableView)
            return todoTasksCount.map { "\(ProcessStatus.todo.description) \($0)" }
        }
    }
    
    // MARK: - TaskEditView
    // TODO: Popover에서 Title/Body/DueData Edit 기능 구현
    func edit(task: Task, newTitle: String, newBody: String, newDueDate: Date) {
        let newTask = Task(id: task.id, title: newTitle, body: newBody, dueDate: newDueDate, processStatus: task.processStatus)
        update(task: task, to: newTask)
    }
    
    // TODO: Popover에서 ProcessStatus Edit 기능 구현
    func edit(task: Task, newProcessStatus: ProcessStatus) {
        guard task.processStatus != newProcessStatus else {
            print(TaskManagerError.unchangedProcessStatus)
            return
        }
        
        let newTask = Task(id: task.id, title: task.title, body: task.body, dueDate: task.dueDate, processStatus: newProcessStatus)
        update(task: task, to: newTask)
    }
}
