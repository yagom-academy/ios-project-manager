import UIKit
import RxSwift

protocol TaskDetailViewModelInputProtocol {
    func create(task: Task)
    func update(task: Task, to newTask: Task)
    func edit(task: Task, newTitle: String, newBody: String, newDueDate: Date)
    
    func leftBarButton(of taskManagerAction: TaskManagerAction) -> UIBarButtonItem.SystemItem
    func rightBarButton(of taskManagerAction: TaskManagerAction) -> UIBarButtonItem.SystemItem
}

protocol TaskDetailViewModelOutputProtocol {
    var taskRepository: TaskRepositoryProtocol { get }
    var todoTasks: Observable<[Task]> { get }
    var doingTasks: Observable<[Task]> { get }
    var doneTasks: Observable<[Task]> { get }
}

protocol TaskDetailViewModelProtocol: TaskDetailViewModelInputProtocol, TaskDetailViewModelOutputProtocol { }

final class TaskDetailViewModel: TaskDetailViewModelProtocol {
    // MARK: - Properties
    let taskRepository: TaskRepositoryProtocol
    
    lazy var todoTasks: Observable<[Task]> = taskRepository.todoTasks
    lazy var doingTasks: Observable<[Task]> = taskRepository.doingTasks
    lazy var doneTasks: Observable<[Task]> = taskRepository.doneTasks
    
    private var disposeBag = DisposeBag()
    
    // MARK: - Initializers
    init(taskRepository: TaskRepositoryProtocol) {
        self.taskRepository = taskRepository
    }
    
    // MARK: - Methods
    func create(task: Task) {
        taskRepository.create(task: task)
    }
    
    func update(task: Task, to newTask: Task) {
        guard task != newTask else {
            print(TaskManagerError.updateNotFound.description)
            return
        }

        taskRepository.update(task: task, to: newTask)
    }
    
    func edit(task: Task, newTitle: String, newBody: String, newDueDate: Date) {
        let newTask = Task(id: task.id, title: newTitle, body: newBody, dueDate: newDueDate, processStatus: task.processStatus)
        update(task: task, to: newTask)
    }
    
    // MARK: - Navigation Bar
    func leftBarButton(of taskManagerAction: TaskManagerAction) -> UIBarButtonItem.SystemItem {
        switch taskManagerAction {
        case .add:
            return .cancel
        case .edit:
            return .cancel
        }
    }
    
    func rightBarButton(of taskManagerAction: TaskManagerAction) -> UIBarButtonItem.SystemItem {
        switch taskManagerAction {
        case .add:
            return .done
        case .edit:
            return .edit
        }
    }
}
