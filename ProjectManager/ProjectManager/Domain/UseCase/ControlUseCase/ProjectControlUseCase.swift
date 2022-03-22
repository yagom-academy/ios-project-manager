import Foundation
import RxSwift
import RxRelay

final class ProjectControlUseCase: ListCreateUseCase, ListReadUseCase, ListUpdateUseCase, ListDeleteUseCase {
    
    private let repository: DataRepository
    private let disposeBag = DisposeBag()
    
    init(repository: DataRepository) {
        self.repository = repository
    }
   
    func createProject(object: Listable) {
        self.repository.create(object: object)
    }
    
    func readProject(identifier: String) -> Listable? {
        self.repository.fetch()
        return self.repository.read(identifier: identifier)
    }
    
    func updateProject(
        identifier: String,
        how object: Listable
    )  {
        self.repository.update(identifier: identifier, how: object)
        self.repository.fetch()
    }
    
    func deleteProject(identifier: String) {
        self.repository.delete(identifier: identifier)
        self.repository.fetch()
    }
    
    func extractDataSourceRelay() -> BehaviorRelay<[Listable]> {
        return self.repository.rxLists
    }
}
