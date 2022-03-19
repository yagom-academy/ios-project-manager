import Foundation
import RxSwift
import RxRelay

final class ProjectControlUseCase: ControlUseCase { 
    
    var repository: DataRepository?
    var rxLists = BehaviorRelay<[Listable]>(value: []) 
    let disposeBag = DisposeBag()
    
    init(repository: DataRepository) {
        self.repository = repository
    }
   
    func createProject(object: Listable) {
        self.repository?.create(object: object)
        var current = rxLists.value
        current.append(object)
        self.rxLists.accept(current)
    }
    
    func readProject(identifier: String) -> Listable? {
        self.repository?.read(identifier: identifier)
    }
    
    func updateProject(
        identifier: String,
        how object: Listable
    )  {
        self.repository?.update(identifier: identifier, how: object)
        fetch()
    }
    
    func deleteProject(identifier: String) {
        self.repository?.delete(identifier: identifier)
        fetch()
    }
    
    func sortProjectProgressState(state: ProgressState) -> Observable<[Listable]> {
        let list = repository?.extractAll()
        let filteredList = list?.filter{ $0.progressState == state.description } ?? []
        return Observable.of(filteredList)
    }
    
    func fetch() {
        repository?.extractRxAll()
        .subscribe( onNext: { project in
            self.rxLists.accept(project)
        }).disposed(by: self.disposeBag)
    }
}
