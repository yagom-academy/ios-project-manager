import Foundation

protocol ProjectUseCaseProtocol {
    func fetch(with id: UUID) -> Project
    func fetchAll() -> [Project]
    func create(with project: Project)
    func update(with project: Project)
    func delete(with project: Project)
}

class ProjectUseCase: ProjectUseCaseProtocol {
    let projectRepository: ProjectRepositoryProtocol
    
    init(repository: ProjectRepositoryProtocol) {
        self.projectRepository = repository
    }

    func fetchAll() -> [Project] {
        return projectRepository.fetchAll()
            .map { $0.value }
            .sorted { $0.date > $1.date }
    }
    
    func fetch(with id: UUID) -> Project {
        let fetchedData = projectRepository.fetchAll()
        
        return fetchedData
            .map { $0.value }
            .filter{ $0.id == id }.first!
    }
    
    func create(with project: Project) {
        projectRepository.create(with: project)
    }
    
    func update(with project: Project) {
        let oldProject = fetch(with: project.id)
        let newProject = Project(id: oldProject.id, state: oldProject.state, title: project.title, body: project.body, date: project.date)
        
        projectRepository.update(with: newProject)
    }
    
    func delete(with project: Project) {
        projectRepository.delete(with: project)
    }
}
