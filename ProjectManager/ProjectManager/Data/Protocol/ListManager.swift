import Foundation

protocol DataRepository {
    
    var list: [Listable] { get }
    
    func creatProject(attributes: [String: Any])
    
    func readProject(index: IndexPath) -> Listable?
    
    func updateProject(
        to index: IndexPath,
        how attributes: [String: Any]
    ) 
    
    func deleteProject(index: IndexPath)
    
    func fetch()
}
