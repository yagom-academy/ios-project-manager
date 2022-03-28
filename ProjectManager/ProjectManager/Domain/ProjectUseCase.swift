import Foundation
import RxSwift
import RxRelay

protocol ProjectUseCaseProtocol {
    func fetch(with id: UUID) -> Project?
    func bindProjects() -> Observable<[Project]>
    func append(_ project: Project)
    func update(_ project: Project, to state: ProjectState?)
    func delete(_ project: Project)
}

final class ProjectUseCase: ProjectUseCaseProtocol {
    let disposeBag = DisposeBag()
    let projectRepository: ProjectRepositoryProtocol
    
    init(repository: ProjectRepositoryProtocol) {
        self.projectRepository = repository
    }

    func bindProjects() -> Observable<[Project]> {
        return projectRepository.bindProjects()
            .map {
                $0.map { $0.value }
                .sorted { $0.date > $1.date }
            }
    }
    
    func fetch(with id: UUID) -> Project? {
        return projectRepository.bindProjects().value[id]
    }
    
    func append(_ project: Project) {
        projectRepository.append(project)
    }
    
    func update(_ project: Project, to state: ProjectState?) {
        guard let oldProject = fetch(with: project.id) else {
            return
        }
        var newProject = oldProject
        
        if let updatedState = state {
            newProject = Project(id: oldProject.id, state: updatedState, title: project.title, body: project.body, date: project.date)
        } else {
            newProject = Project(id: oldProject.id, state: project.state, title: project.title, body: project.body, date: project.date)
        }
        projectRepository.update(newProject)
    }

    func delete(_ project: Project) {
        projectRepository.delete(project)
    }
}
