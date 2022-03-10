import Foundation

protocol ProjectRepositoryProtocol {
    var projects: [UUID: Project] { get set }
    func update(with project: Project)
    func fetchAll() -> [UUID: Project]
}

class ProjectRepository: ProjectRepositoryProtocol {
    var projects: [UUID: Project] = [:]
    
    func update(with project: Project) {
        projects.updateValue(project, forKey: project.id)
    }
    
    func fetchAll() -> [UUID: Project] {
        return projects
    }
}
