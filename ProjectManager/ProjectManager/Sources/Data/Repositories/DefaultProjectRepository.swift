import Foundation
import RxSwift

final class DefaultProjectRepository {
    private let storage: ProjectStorage
    let disposeBag = DisposeBag()

    init(storage: ProjectStorage = DefaultProjectStorage()) {
        self.storage = storage
    }
}

extension DefaultProjectRepository: ProjectRepository {
    func create(_ item: Project) -> Single<Project> {
        storage.create(item)
    }
    
    func update(with item: Project?) -> Single<Project> {
        storage.update(item)
    }
    
    func delete(_ item: Project?) -> Single<Project> {
        storage.delete(item)
    }
    
    func fetch() -> BehaviorSubject<[Project]> {
        return storage.fetch()
    }
}
