import Foundation
import RxSwift
import RxRelay

protocol ControlUseCase {
    
    var repository: DataRepository? { get set }
    var rxLists: BehaviorRelay<[Listable]> { get set }
    
    func createProject(object: Listable)
    
    func readProject(identifier: String) -> Listable?
    
    func updateProject(
        identifier: String,
        how object: Listable
    )
    
    func deleteProject(identifier: String)
    
    func sortProjectProgressState(state: ProgressState) -> Observable<[Listable]>
        
    func fetch()
}

