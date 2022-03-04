import Foundation

protocol TaskUseCase {
    func execute() -> [TaskEntity]
    func changeStatus()
    func delete()
}

final class FetchTaskUseCase: TaskUseCase {
    private var repository: TaskRepository
    
    init(repository: TaskRepository) {
        self.repository = repository
    }
    
    func execute() -> [TaskEntity] {
        repository.fetchTasks()
    }
    
    func changeStatus() {}
    
    func delete() {}
}
