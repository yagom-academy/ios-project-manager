import Foundation

protocol DataRepository {
    
    var list: [Listable] { get }
    
    func creatProject(attributes: [String: Any]) -> Listable
    
    func readProject(index: IndexPath) -> Listable
    
    func updateProject(
        to index: IndexPath,
        how attributes: [String: Any]
    ) -> Listable
    
    func deleteProject(index: IndexPath)
    
    func fetch()
}
