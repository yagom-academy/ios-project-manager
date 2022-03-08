import Foundation

protocol CRUDUseCase {
    
    var repository: DataRepository? { get set }
    var todoProjects: [Listable] { get set }
    var doingProjects: [Listable] { get set }
    var doneProjects: [Listable] { get set }
    
    func createProject(attributes: [String: Any])
    
    func readProject(identifier: String) -> Listable?
    
    func updateProject(
        identifier: String,
        how attributes: [String: Any]
    )
    
    func deleteProject(identifier: String)
    
    func sortProjectProgressState(state: ProgressState) -> [Listable]
}
