import Foundation
import RxSwift

protocol ProjectRepository {
    @discardableResult
    func create(_ item: Project) -> Single<Project>
    @discardableResult
    func update(with item: Project?) -> Single<Project>
    @discardableResult
    func delete(_ item: Project?) -> Single<Project>
    func fetch() -> BehaviorSubject<[Project]>
    func fetch(id: UUID) -> Single<Project>
}
