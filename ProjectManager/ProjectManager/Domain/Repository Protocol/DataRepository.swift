import Foundation
import RxSwift

protocol DataRepository {
    
    func create(object: Listable)
    
    func read(identifier: String) -> Listable?
    
    func update(
        identifier: String,
        how object: Listable
    ) 
    
    func delete(identifier: String)
    
    func fetch()
    
    func extractAll() -> [Listable]
    
    func extractRxAll() -> Observable<[Listable]>
}
