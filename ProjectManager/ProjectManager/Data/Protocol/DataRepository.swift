import Foundation

protocol DataRepository {
    
    func create(attributes: [String: Any])
    
    func read(identifier: String) -> Listable?
    
    func update(
        identifier: String,
        how attributes: [String: Any]
    ) 
    
    func delete(identifier: String)
    
    func fetch()
    
    func extractAll() -> [Listable] 
}
