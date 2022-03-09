import Foundation
import RxSwift

final class VolatileMemoryRepository {
    private let storage: Storage
    let disposeBag = DisposeBag()

    init(storage: Storage = VolatileMemoryStorage()) {
        self.storage = storage
    }
}

extension VolatileMemoryRepository: VolatileRepository {
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
