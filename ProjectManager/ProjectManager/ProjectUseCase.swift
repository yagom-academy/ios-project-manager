import Foundation

protocol ProjectUseCaseProtocol {
    func fetch(with id: UUID) -> Project
    func update(with project: Project)
}

class ProjectUseCase: ProjectUseCaseProtocol {
    let projectRepository: ProjectRepositoryProtocol
    
    init(repository: ProjectRepositoryProtocol) {
        self.projectRepository = repository
    }

    func fetch(with id: UUID) -> Project {
        let fetchedData = projectRepository.fetchAll()
        
        return fetchedData
            .map { $0.value }
            .filter{ $0.id == id }.first!
    }

    func update(with project: Project) {
        let project = fetch(with: project.id)
        projectRepository.update(with: project)
    }
}
