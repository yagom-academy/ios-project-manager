import Foundation

protocol TaskUseCase {
    func executeFetch() -> [TaskEntity]
    func changeStatus()
    func delete()
}

final class FetchTaskUseCase: TaskUseCase {
    private var repository: TaskRepository
    
    init(repository: TaskRepository) {
        self.repository = repository
    }
    
    func executeFetch() -> [TaskEntity] {
        return repository.readAll()
    }
    
    func changeStatus() {}
    
    func delete() {}
}
