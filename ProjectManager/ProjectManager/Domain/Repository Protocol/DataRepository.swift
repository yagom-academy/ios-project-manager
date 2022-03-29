import Foundation
import RxSwift
import RxRelay

protocol DataRepository {
    
    var storage: BehaviorRelay<[Listable]> { get }
    
    func create(object: Listable)
    
    func read(identifier: String) -> Listable?
    
    func update(from
        identifier: String,
        to object: Listable
    ) 
    
    func delete(identifier: String)
}
