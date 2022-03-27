import Foundation
import RxSwift
import RxRelay

protocol DataRepository {
    
    var storage: BehaviorRelay<[Listable]> { get set }
    
    func create(object: Listable)
    
    func read(identifier: String) -> Listable?
    
    func update(
        identifier: String,
        how object: Listable
    ) 
    
    func delete(identifier: String)
}
