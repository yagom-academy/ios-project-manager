import Foundation
import RxSwift

final class MemoryRepository {
    private let storage: Storageable
    let disposeBag = DisposeBag()

    init(storage: Storageable = MemoryStorage()) {
        self.storage = storage
    }
}

extension MemoryRepository: Repositoryable {
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
