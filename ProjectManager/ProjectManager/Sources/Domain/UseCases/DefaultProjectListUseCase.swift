import Foundation
import RxSwift

struct DefaultProjectListUseCase {
    private let repository: ProjectRepository
    
    init(repository: ProjectRepository = DefaultProjectRepository()) {
        self.repository = repository
    }
}

extension DefaultProjectListUseCase: ProjectListUseCase {
    func create(_ project: Project) -> Single<Project> {
        repository.create(project)
    }
    
    func update(_ project: Project?) -> Single<Project> {
        repository.update(with: project)
    }
    
    func delete(_ uuid: UUID) -> Single<Project> {
        repository.delete(uuid)
    }
    
    func fetch() -> BehaviorSubject<[Project]> {
        return repository.fetch()
    }
}
