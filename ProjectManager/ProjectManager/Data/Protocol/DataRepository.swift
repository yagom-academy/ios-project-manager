import Foundation

protocol DataRepository {
    
    var list: [Listable] { get set }
    
    func creat(attributes: [String: Any])
    
    func read(identifier: String) -> Listable?
    
    func update(
        identifier: String,
        how attributes: [String: Any]
    ) 
    
    func delete(identifier: String)
    
    func fetch()
}
