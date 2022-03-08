import Foundation
import RxSwift

struct MemoryUseCase {
    private let repository: Repositoryable
    
    init(repository: Repositoryable = MemoryRepository()) {
        self.repository = repository
    }
}

extension MemoryUseCase: UseCase {
    func create(_ project: Project) -> Single<Project> {
        repository.create(project)
    }
    
    func update(_ project: Project?) -> Single<Project> {
        repository.update(with: project)
    }
    
    func delete(_ project: Project?) -> Single<Project> {
        repository.delete(project)
    }
    
    func fetch() -> BehaviorSubject<[Project]> {
        return repository.fetch()
    }
}
