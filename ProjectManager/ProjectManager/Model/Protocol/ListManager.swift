import Foundation

protocol ListManager {
    
    var list: [Listable] { get }
    
    func creatProject(attributes: [String: [Any]]) -> Listable
    
    func readProject(index: Int) -> Listable
    
    func updateProject(
        to subject: Listable,
        how attributes: [String: [Any]]
    ) -> Listable
    
    func deleteProject(index: Int)
    
    func save()
}
