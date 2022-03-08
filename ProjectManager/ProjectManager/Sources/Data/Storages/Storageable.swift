import Foundation
import RxSwift

protocol Storageable {
    func create(_ item: Project) -> Single<Project>
    func update(_ project: Project?) -> Single<Project>
    func delete(_ project: Project?) -> Single<Project>
    func fetch() -> BehaviorSubject<[Project]>
}
