import Foundation
import RxSwift

protocol ProjectStorage {
    @discardableResult
    func create(_ item: Project) -> Single<Project>
    @discardableResult
    func update(_ project: Project?) -> Single<Project>
    @discardableResult
    func delete(_ uuid: UUID) -> Single<Project>
    func fetch() -> BehaviorSubject<[Project]>
}
