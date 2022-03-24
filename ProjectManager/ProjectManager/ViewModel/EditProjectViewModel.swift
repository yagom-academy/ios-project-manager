import Foundation

class EditProjectViewModel {
    private let repository: ProjectRepository
    
    init(repository: ProjectRepository) {
        self.repository = repository
    }
    
    func editProject(with projectInput: ProjectInput) {
        repository.editProject(with: projectInput)
    }
}
