import Foundation

final class ProjectManagerUseCase: CRUDUseCase {
    
    var repository: DataRepository?
    var todoProjects = [Listable]()
    var doingProjects = [Listable]()
    var doneProjects = [Listable]()
    
    init(repository: DataRepository) {
        self.repository = repository
    }
   
    func createProject(attributes: [String: Any]) {
        self.repository?.creat(attributes: attributes)
    }
    
    func readProject(identifier: String) -> Listable? {
        self.repository?.read(identifier: identifier)
    }
    
    func updateProject(
        identifier: String,
        how attributes: [String: Any]
    )  {
        self.repository?.update(identifier: identifier, how: attributes)
    }
    
    func deleteProject(identifier: String) {
        self.repository?.delete(identifier: identifier)
    }
    
    func sortProjectProgressState(state: ProgressState) -> [Listable] {
        self.repository?.list.filter{ $0.progressState == state.description } ?? []
    }
}
