import Foundation
import RxSwift

protocol VolatileRepository {
    func create(_ item: Project) -> Single<Project>
    func update(with item: Project?) -> Single<Project>
    func delete(_ item: Project?) -> Single<Project>
    func fetch() -> BehaviorSubject<[Project]>
}
