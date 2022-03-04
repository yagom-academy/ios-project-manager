import Foundation
import RxSwift

final class ProjectListViewModel {
    private(set) var projects = [Project]()
    private let useCase: UseCase
    
    init(useCase: UseCase = MemoryUseCase()) {
        self.useCase = useCase
    }

    // MARK: - Output
    var inserted = PublishSubject<Bool>()
    var updated = PublishSubject<IndexPath>()
    var deleted = PublishSubject<IndexPath>()
    var errorMessage = PublishSubject<String>()

    // MARK: - input
    func add(_ project: Project) {
        useCase.create(project) { item in
            guard item != nil else {
                self.errorMessage.onNext("알 수 없는 에러가 발생했습니다.")
                return
            }
            self.projects = self.useCase.fetch()
            self.inserted.onNext(true)
        }
    }
    
    func update(_ project: Project, indexPath: IndexPath) {
        useCase.update(project) { item in
            guard item != nil else {
                self.errorMessage.onNext("존재하지 않는 Project 입니다.")
                return
            }
            self.projects = self.useCase.fetch()
            self.updated.onNext(indexPath)
        }
    }
    
    func delete(_ indexPath: IndexPath, completion: ((Project?) -> Void)?) {
        useCase.delete(projects[safe: indexPath.row]) { item in
            guard let item = item else {
                self.errorMessage.onNext("삭제를 실패했습니다.")
                completion?(nil)
                return
            }
            self.projects = self.useCase.fetch()
            self.deleted.onNext(indexPath)
            completion?(item)
        }
    }
}
