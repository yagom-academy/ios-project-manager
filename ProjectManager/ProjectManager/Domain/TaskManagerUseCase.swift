import Foundation
import RxSwift

class TaskManagerUseCase {
    var taskRepository: TaskRepositoryProtocol!
    let todoTasks: BehaviorSubject<[Task]>
    let doingTasks: BehaviorSubject<[Task]>
    let doneTasks: BehaviorSubject<[Task]>
    
    init(taskRepository: TaskRepositoryProtocol) {
        self.taskRepository = taskRepository
        self.todoTasks = BehaviorSubject<[Task]>(value: taskRepository.todoTasks)
        self.doingTasks = BehaviorSubject<[Task]>(value: taskRepository.doingTasks)
        self.doneTasks = BehaviorSubject<[Task]>(value: taskRepository.doneTasks)
    }
    
    func create(task: Task) {
        taskRepository.create(task: task)
    }
    
    func delete(task: Task) {
        taskRepository.delete(task: task)
    }
    
    func update(task: Task, to newTask: Task) {
        taskRepository.update(task: task, to: newTask)
    }
}
