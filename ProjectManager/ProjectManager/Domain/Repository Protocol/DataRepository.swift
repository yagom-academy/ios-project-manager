import Foundation
import RxSwift
import RxRelay

protocol DataRepository {
    
    var rxLists: BehaviorRelay<[Listable]> { get set }
    
    func create(object: Listable)
    
    func read(identifier: String) -> Listable?
    
    func update(
        identifier: String,
        how object: Listable
    ) 
    
    func delete(identifier: String)
    
    func fetch()
    
    func extractAll() -> [Listable]
}
