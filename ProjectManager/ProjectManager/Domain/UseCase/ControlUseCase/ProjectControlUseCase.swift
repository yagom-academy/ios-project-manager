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
        return self.repository.read(identifier: identifier)
    }
    
    func updateProject(
        identifier: String,
        how object: Listable
    )  {
        self.repository.update(identifier: identifier, how: object)
    }
    
    func deleteProject(identifier: String) {
        self.repository.delete(identifier: identifier)
    }
    
    func extractDataSourceRelay() -> BehaviorRelay<[Listable]> {
        return self.repository.storage
    }
}
