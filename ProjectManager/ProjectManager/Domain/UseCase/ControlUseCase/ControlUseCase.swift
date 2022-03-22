import Foundation
import RxSwift
import RxRelay

protocol ListCreateUseCase {
    
    func createProject(object: Listable)
    
    func extractDataSourceRelay() -> BehaviorRelay<[Listable]>
}

protocol ListReadUseCase {
    
    func readProject(identifier: String) -> Listable?
    
    func extractDataSourceRelay() -> BehaviorRelay<[Listable]>
}

protocol ListUpdateUseCase {
    
    func updateProject(
        identifier: String,
        how object: Listable
    )
    
    func extractDataSourceRelay() -> BehaviorRelay<[Listable]>
}

protocol ListDeleteUseCase {
    
    func deleteProject(identifier: String)
    
    func extractDataSourceRelay() -> BehaviorRelay<[Listable]>
}
