import Foundation

class ProjectManagerUseCase: UseCase {
    
    var repository: DataRepository?
    
    init(repository: DataRepository? = nil) {
        self.repository = repository
    }
    
    func createProject() {
        <#code#>
    }
    
    func readProject() {
        <#code#>
    }
    
    func updateProject() {
        <#code#>
    }
    
    func deleteProject() {
        <#code#>
    }
    
    
}
