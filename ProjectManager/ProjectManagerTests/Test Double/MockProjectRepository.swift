import Foundation
@testable import ProjectManager

class MockProjectRepository: ProjectRepositoryProtocol {
    var projects: [UUID : Project]
    
    init(projects: [UUID : Project]) {
        self.projects = projects
    }
    
    func fetchAll() -> [UUID: Project] {
        return projects
    }
    
    func append(_ project: Project) {
        projects[project.id] = project
    }
    
    func update(_ project: Project) {
        projects.updateValue(project, forKey: project.id)
    }
    
    func delete(_ project: Project) {
        projects.removeValue(forKey: project.id)
    }
}
