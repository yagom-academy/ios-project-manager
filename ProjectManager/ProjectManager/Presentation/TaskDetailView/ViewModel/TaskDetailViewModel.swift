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
    var todoTasks: BehaviorSubject<[Task]> { get }
    var doingTasks: BehaviorSubject<[Task]> { get }
    var doneTasks: BehaviorSubject<[Task]> { get }
}

protocol TaskDetailViewModelProtocol: TaskDetailViewModelInputProtocol, TaskDetailViewModelOutputProtocol { }

final class TaskDetailViewModel: TaskDetailViewModelProtocol {
    private let taskRepository: TaskRepositoryProtocol
    let todoTasks: BehaviorSubject<[Task]>
    let doingTasks: BehaviorSubject<[Task]>
    let doneTasks: BehaviorSubject<[Task]>
    
    init(taskRepository: TaskRepositoryProtocol) {
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
//            taskRepository.todoTasks
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
        
        guard task.processStatus != newTask.processStatus else { return }
        
        switch newTask.processStatus {
        case .todo:
            todoTasks.onNext(taskRepository.todoTasks)
        case .doing:
            doingTasks.onNext(taskRepository.doingTasks)
        case .done:
            doneTasks.onNext(taskRepository.doneTasks)
        }
    }
    
    func edit(task: Task, newTitle: String, newBody: String, newDueDate: Date) {
        let newTask = Task(id: task.id, title: newTitle, body: newBody, dueDate: newDueDate, processStatus: task.processStatus)
        update(task: task, to: newTask)
    }
    
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
