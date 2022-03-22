import Foundation
import RxSwift
import RxRelay

protocol ListCreateUseCase {
    
    func createProject(object: Listable)
    
    func extractAll() -> BehaviorRelay<[Listable]>
    
    func fetch()
}

protocol ListReadUseCase {
    
    func readProject(identifier: String) -> Listable?
    
    func extractAll() -> BehaviorRelay<[Listable]>
    
    func fetch()
}

protocol ListUpdateUseCase {
    
    func updateProject(
        identifier: String,
        how object: Listable
    )
    
    func extractAll() -> BehaviorRelay<[Listable]>
    
    func fetch()
}

protocol ListDeleteUseCase {
    
    func deleteProject(identifier: String)
    
    func extractAll() -> BehaviorRelay<[Listable]>
    
    func fetch()
}
