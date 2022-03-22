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
    func fetch(id: UUID) -> Single<Project>
    func changedState(_ project: Project, state: ProjectState)
    func isNotValidate(_ text: String?) -> Bool
}
