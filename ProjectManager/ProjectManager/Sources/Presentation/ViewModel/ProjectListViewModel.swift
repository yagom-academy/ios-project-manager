import Foundation

final class ProjectListViewModel {
    private(set) var projects = [Project]()
    private let useCase: UseCase
    
    init(useCase: UseCase = MemoryUseCase()) {
        self.useCase = useCase
    }

    // MARK: - Output
    var inserted: Observable<Bool> = Observable(false)
    var updated: Observable<IndexPath> = Observable(IndexPath(row: .zero, section: .zero))
    var deleted: Observable<IndexPath> = Observable(IndexPath(row: .zero, section: .zero))
    var errorMessage: Observable<String> = Observable("")

    // MARK: - input
    func add(_ project: Project) {
        useCase.create(project) { item in
            guard item != nil else {
                self.errorMessage.value = "알 수 없는 에러가 발생했습니다."
                return
            }
            self.projects = self.useCase.fetch()
            self.inserted.value = !self.inserted.value
        }
    }
    
    func update(_ indexPath: IndexPath) {
        useCase.update(projects[safe: indexPath.row]) { item in
            guard item != nil else {
                self.errorMessage.value = "존재하지 않는 Project 입니다."
                return
            }
            self.projects = self.useCase.fetch()
            self.updated.value = indexPath
        }
    }
    
    func delete(_ indexPath: IndexPath, completion: ((Project?) -> Void)?) {
        useCase.delete(projects[safe: indexPath.row]) { item in
            guard let item = item else {
                self.errorMessage.value = "삭제를 실패했습니다."
                completion?(nil)
                return
            }
            self.deleted.value = indexPath
            self.projects = self.useCase.fetch()
            completion?(item)
        }
    }
}
