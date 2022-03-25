import Foundation
import RxSwift
import RxRelay

protocol TaskRepositoryProtocol {
    var entireTasks: BehaviorRelay<[Task]> { get }
    var todoTasks: Observable<[Task]> { get }
    var doingTasks: Observable<[Task]> { get }
    var doneTasks: Observable<[Task]> { get }

    func create(task: Task)
    func delete(task: Task)
    func update(task: Task, to newTask: Task)
}

final class TaskRepository: TaskRepositoryProtocol {
    let entireTasks: BehaviorRelay<[Task]>
    
    lazy var todoTasks: Observable<[Task]> = entireTasks.map { tasks in
        tasks.filter { $0.processStatus == .todo }
    }
    lazy var doingTasks: Observable<[Task]> = entireTasks.map { tasks in
        tasks.filter { $0.processStatus == .doing }
    }
    lazy var doneTasks: Observable<[Task]> = entireTasks.map { tasks in
        tasks.filter { $0.processStatus == .done }
    }
    
    init(tasks: [Task] = []) {
//        self.entireTasks = BehaviorRelay<[Task]>(value: tasks)
        
        // Dummy Data
        self.entireTasks = BehaviorRelay<[Task]>(value: [
                                Task(title: "TODO-1", body: "Rx를 곁들인", dueDate: Date()),
                                Task(title: "TODO-2", body: "RxSwift", dueDate: Date(timeIntervalSinceReferenceDate: 0)),
                                Task(title: "TODO-3", body: "마감기한이 빠른 순으로 정렬", dueDate: Date(timeIntervalSinceReferenceDate: 157680000)),
                                Task(title: "DOING-1", body: "RxCocoa", dueDate: Date(), processStatus: .doing),
                                Task(title: "DONE-1", body: "MVVM", dueDate: Date(), processStatus: .done)
                            ])
    }
    
    func create(task: Task) {
        var currentTasks = entireTasks.value
        currentTasks.append(task)
        entireTasks.accept(currentTasks)
    }
    
    func delete(task: Task) {
        var currentTasks = entireTasks.value
        if let index = findIndex(with: task.id) {
            currentTasks.remove(at: index)
        }
        entireTasks.accept(currentTasks)
    }
    
    func update(task: Task, to newTask: Task) {
        var currentTasks = entireTasks.value
        if let index = findIndex(with: task.id) {
            currentTasks[index] = newTask
        }
        entireTasks.accept(currentTasks)
    }
    
    func findIndex(with id: UUID) -> Int? {
        let currentTasks = entireTasks.value
        guard let index = currentTasks.firstIndex(where: { $0.id == id }) else {
            print(TaskManagerError.taskNotFound.description)
            return nil
        }
        
        return index
    }
}
