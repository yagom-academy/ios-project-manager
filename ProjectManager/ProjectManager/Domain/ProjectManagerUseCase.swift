import Foundation
import RxSwift

final class ProjectManagerUseCase: ProjectManagingUseCase {
    
    var differenceHistories: [(state: ManageState, identifier: String, object: Listable)] = [] 
    var repository: DataRepository?

    init(repository: DataRepository) {
        self.repository = repository
    }
   
    func createProject(object: Listable) {
        self.repository?.create(object: object)
    }
    
    func readProject(identifier: String) -> Listable? {
        self.repository?.read(identifier: identifier)
    }
    
    func updateProject(
        identifier: String,
        how object: Listable
    )  {
        self.repository?.update(identifier: identifier, how: object)
    }
    
    func deleteProject(identifier: String) {
        self.repository?.delete(identifier: identifier)
    }
    
    func sortProjectProgressState(state: ProgressState) -> Observable<[Listable]> {
        let list = repository?.extractAll()
        let filteredList = list?.filter{ $0.progressState == state.description } ?? []
        return Observable.of(filteredList)
    }
    
    func saveDifference(method: ManageState, identifier: String, object: Listable) {
        differenceHistories.append((state: method, identifier: identifier, object: object))
    }
    
}
