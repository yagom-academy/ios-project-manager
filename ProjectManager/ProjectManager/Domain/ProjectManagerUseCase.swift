import Foundation

final class ProjectManagerUseCase: ProjectManagingUseCase {
    
    var repository: DataRepository?
    var todoProjects = [Listable]()
    var doingProjects = [Listable]()
    var doneProjects = [Listable]()

    init(repository: DataRepository) {
        self.repository = repository
    }
   
    func createProject(object: Listable) {
        self.repository?.create(object: object)
    }
    
    func readProject(identifier: String) -> Listable? {
        self.repository?.read(identifier: identifier)
    }
    
    func updateProject(
        identifier: String,
        how object: Listable
    )  {
        self.repository?.update(identifier: identifier, how: object)
    }
    
    func deleteProject(identifier: String) {
        self.repository?.delete(identifier: identifier)
    }
    
    func sortProjectProgressState(state: ProgressState) -> [Listable] {
        let list = repository?.extractAll()
        let filteredList = list?.filter{ $0.progressState == state.description } ?? []
        return filteredList
    }
}
