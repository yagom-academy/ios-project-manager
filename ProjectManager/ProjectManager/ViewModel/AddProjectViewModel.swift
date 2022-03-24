import Foundation

class AddProjectViewModel {
    private let repository: ProjectRepository
    
    init(repository: ProjectRepository) {
        self.repository = repository
    }
    
    func addProject(with projectInput: ProjectInput) {
        repository.addProject(projectInput: projectInput)
    }
}
