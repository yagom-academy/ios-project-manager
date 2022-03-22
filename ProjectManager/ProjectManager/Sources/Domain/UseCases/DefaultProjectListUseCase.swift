import Foundation
import RxSwift

struct DefaultProjectListUseCase {
    private let repository: ProjectRepository
    
    init(repository: ProjectRepository = DefaultProjectRepository()) {
        self.repository = repository
    }
}

extension DefaultProjectListUseCase: ProjectListUseCase {
    @discardableResult
    func create(_ project: Project) -> Single<Project> {
        repository.create(project)
    }
    
    @discardableResult
    func update(_ project: Project?) -> Single<Project> {
        repository.update(with: project)
    }
    
    @discardableResult
    func delete(_ item: Project?) -> Single<Project> {
        repository.delete(item)
    }
    
    func fetch() -> BehaviorSubject<[Project]> {
        return repository.fetch()
    }
    
    func fetch(id: UUID) -> Single<Project> {
        return repository.fetch(id: id)
    }
    
    func changedState(_ project: Project, state: ProjectState) {
        var newProject = project
        newProject.status = state
        update(newProject)
    }
    
    func isNotValidate(_ text: String?) -> Bool {
        return text?.count ?? .zero > 1000 || text == "" || text == Placeholder.body
    }
}
