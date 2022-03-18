import Foundation
import RxSwift
import RxRelay

protocol UseCaseProvider {
    
    var repository: DataRepository? { get set }
    var differenceHistories: [(state: ManageState, identifier: String, object: Listable)] { get set }
    var rxLists: BehaviorRelay<[Listable]> { get set }
    
    func createProject(object: Listable)
    
    func readProject(identifier: String) -> Listable?
    
    func updateProject(
        identifier: String,
        how object: Listable
    )
    
    func deleteProject(identifier: String)
    
    func sortProjectProgressState(state: ProgressState) -> Observable<[Listable]>
    
    func saveDifference(method: ManageState, identifier: String, object: Listable)
    
    func fetch()
}

