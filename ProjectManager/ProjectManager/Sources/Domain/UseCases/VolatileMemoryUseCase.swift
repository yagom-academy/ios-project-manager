import Foundation
import RxSwift

struct VolatileMemoryUseCase {
    private let repository: VolatileRepository
    
    init(repository: VolatileRepository = VolatileMemoryRepository()) {
        self.repository = repository
    }
}

extension VolatileMemoryUseCase: ProjectListUseCase {
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
