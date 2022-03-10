import Foundation

protocol ProjectManagingUseCase {
    
    var repository: DataRepository? { get set }
    var todoProjects: [Listable] { get }
    var doingProjects: [Listable] { get }
    var doneProjects: [Listable] { get }
    
    func createProject(attributes: [String: Any])
    
    func readProject(identifier: String) -> Listable?
    
    func updateProject(
        identifier: String,
        how attributes: [String: Any]
    )
    
    func deleteProject(identifier: String)
    
    func sortProjectProgressState(state: ProgressState) -> [Listable]
}
