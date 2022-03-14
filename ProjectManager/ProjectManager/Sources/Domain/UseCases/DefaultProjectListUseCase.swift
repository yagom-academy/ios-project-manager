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
    
    func delete(_ item: Project?) -> Single<Project> {
        repository.delete(item)
    }
    
    func fetch() -> BehaviorSubject<[Project]> {
        return repository.fetch()
    }
    
    func fetch(id: UUID) -> Single<Project> {
        return repository.fetch(id: id)
    }
}
