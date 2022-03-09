import Foundation
import RxSwift

protocol ProjectListUseCase {
    @discardableResult
    func create(_ item: Project) -> Single<Project>
    @discardableResult
    func update(_ item: Project?) -> Single<Project>
    @discardableResult
    func delete(_ uuid: UUID) -> Single<Project>
    func fetch() -> BehaviorSubject<[Project]>
    @discardableResult
    func changedState(for project: Project, with state: ProjectState) -> Single<Project>
}
