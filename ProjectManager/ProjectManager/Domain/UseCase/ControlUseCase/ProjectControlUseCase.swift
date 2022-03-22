import Foundation
import RxSwift
import RxRelay

final class ProjectControlUseCase: ListCreateUseCase, ListReadUseCase, ListUpdateUseCase, ListDeleteUseCase {
    
    private var repository: DataRepository?
    private let disposeBag = DisposeBag()
    
    init(repository: DataRepository) {
        self.repository = repository
    }
   
    func createProject(object: Listable) {
        self.repository?.create(object: object)
    }
    
    func readProject(identifier: String) -> Listable? {
        self.repository?.fetch()
        return self.repository?.read(identifier: identifier)
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
    
    func fetch() {
        self.repository?.extractRxAll()
        .subscribe(onNext: { project in
            self.repository?.rxLists.accept(project)
        }).disposed(by: self.disposeBag)
    }
    
    func extractAll() -> BehaviorRelay<[Listable]> {
        return self.repository!.rxLists
    }
}
