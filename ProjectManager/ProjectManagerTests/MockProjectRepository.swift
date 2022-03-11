import Foundation
@testable import ProjectManager

class MockProjectRepository: ProjectRepositoryProtocol {
    var projects: [UUID : Project]
    
    init(projects: [UUID : Project]) {
        self.projects = projects
    }
    
    func update(with project: Project) {
        projects.updateValue(project, forKey: project.id)
    }
    
    func fetchAll() -> [UUID: Project] {
        return projects
    }
}
