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
//    private let taskRepository: TaskRepositoryProtocol
    private let useCase: TaskManagerUseCase
    let todoTasks: BehaviorSubject<[Task]>
    let doingTasks: BehaviorSubject<[Task]>
    let doneTasks: BehaviorSubject<[Task]>
    
    init(useCase: TaskManagerUseCase) {
        self.useCase = useCase
//        self.taskRepository = taskRepository
        self.todoTasks = BehaviorSubject<[Task]>(value: useCase.taskRepository.todoTasks)
        self.doingTasks = BehaviorSubject<[Task]>(value: useCase.taskRepository.doingTasks)
        self.doneTasks = BehaviorSubject<[Task]>(value: useCase.taskRepository.doneTasks)
    }
    
    // MARK: - Methods
    func create(task: Task) {
        useCase.create(task: task)
//        taskRepository.create(task: task)
        
        switch task.processStatus {
        case .todo:
            todoTasks.onNext(useCase.taskRepository.todoTasks)
//            todoTasks.onNext(taskRepository.todoTasks)
        case .doing:
            doingTasks.onNext(useCase.taskRepository.doingTasks)
//            doingTasks.onNext(taskRepository.doingTasks)
        case .done:
            doneTasks.onNext(useCase.taskRepository.doneTasks)
//            doneTasks.onNext(taskRepository.doneTasks)
        }
    }
    
    func update(task: Task, to newTask: Task) {
        guard task != newTask else {
            print(TaskManagerError.updateNotFound.description)
            return
        }
        
        useCase.taskRepository.update(task: task, to: newTask)
        
        switch task.processStatus {
        case .todo:
            todoTasks.onNext(useCase.taskRepository.todoTasks)
        case .doing:
            doingTasks.onNext(useCase.taskRepository.doingTasks)
        case .done:
            doneTasks.onNext(useCase.taskRepository.doneTasks)
        }
        
        guard task.processStatus != newTask.processStatus else { return }
        
        switch newTask.processStatus {
        case .todo:
            todoTasks.onNext(useCase.taskRepository.todoTasks)
        case .doing:
            doingTasks.onNext(useCase.taskRepository.doingTasks)
        case .done:
            doneTasks.onNext(useCase.taskRepository.doneTasks)
        }
    }
    
    func edit(task: Task, newTitle: String, newBody: String, newDueDate: Date) {
        let newTask = Task(id: task.id, title: newTitle, body: newBody, dueDate: newDueDate, processStatus: task.processStatus)
        update(task: task, to: newTask)
    }
    
    // TODO: UseCase 추가
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
