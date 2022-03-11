import Foundation

protocol ProjectRepositoryProtocol {
    var projects: [UUID: Project] { get set }
    func update(with project: Project)
    func fetchAll() -> [UUID: Project]
}

class ProjectRepository: ProjectRepositoryProtocol {
    private var projects1 = ProjectViewModel.projects // 테스트용
    
    lazy var projects: [UUID: Project] = [projects1[0].id: projects1[0],
                                          projects1[1].id: projects1[1],
                                          projects1[2].id: projects1[2],
                                          projects1[3].id: projects1[3]] // 테스트용
    
    
    func update(with project: Project) {
        projects.updateValue(project, forKey: project.id)
    }
    
    func fetchAll() -> [UUID: Project] {
        return projects
    }
}
