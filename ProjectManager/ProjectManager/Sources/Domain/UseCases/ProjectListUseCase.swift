import Foundation
import RxSwift

protocol ProjectListUseCase {
    @discardableResult
    func create(_ item: Project) -> Single<Project>
    @discardableResult
    func update(_ item: Project?) -> Single<Project>
    @discardableResult
    func delete(_ item: Project?) -> Single<Project>
    func fetch() -> BehaviorSubject<[Project]>
}
