import Foundation

protocol ProjectManagingUseCase {
    
    var repository: DataRepository? { get set }
    var todoProjects: [Listable] { get }
    var doingProjects: [Listable] { get }
    var doneProjects: [Listable] { get }
    
    func createProject(object: Listable)
    
    func readProject(identifier: String) -> Listable?
    
    func updateProject(
        identifier: String,
        how object: Listable
    )
    
    func deleteProject(identifier: String)
    
    func sortProjectProgressState(state: ProgressState) -> [Listable]
}
