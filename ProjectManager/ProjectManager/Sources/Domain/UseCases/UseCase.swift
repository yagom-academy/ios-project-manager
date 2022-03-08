import Foundation
import RxSwift

protocol UseCase {
    func create(_ item: Project) -> Single<Project>
    func update(_ item: Project?) -> Single<Project>
    func delete(_ item: Project?) -> Single<Project>
    func fetch() -> BehaviorSubject<[Project]>
}
