import Foundation
import RxSwift

final class MemoryStorage {
    private(set) var projects: [Project]
    private let projectStore: BehaviorSubject<[Project]>
    
    init(
        projects: [Project] = [],
        projectStore: BehaviorSubject<[Project]> = BehaviorSubject<[Project]>(value: [])
    ) {
        self.projects = projects
        self.projectStore = projectStore
    }
}

extension MemoryStorage: Storageable {
    func create(_ item: Project) -> Single<Project> {
        projects.append(item)
        projectStore.onNext(projects)
        return Single.just(item)
    }
    
    func update(_ item: Project?) -> Single<Project> {
        guard let item = item,
              let index = projects.firstIndex(where: { $0.id == item.id }) else {
            return Single.create { observer in
            observer(.failure(StorageError.notFound))
            return Disposables.create()
        } }
        projects[index] = item
        projectStore.onNext(projects)
        return Single.create { observer in
            observer(.success(self.projects[index]))
            return Disposables.create()
        }
    }
    
    func delete(_ item: Project?) -> Single<Project> {
        guard let item = item,
              let index = projects.firstIndex(where: { $0.id == item.id }) else {
            return Single.create { observer in
            observer(.failure(StorageError.notFound))
            return Disposables.create()
        } }
        let deletedProject = projects.remove(at: index)
        projectStore.onNext(projects)
        return Single.create { observer in
            observer(.success(deletedProject))
            
            return Disposables.create()
        }
    }
    
    func fetch() -> BehaviorSubject<[Project]> {
        return projectStore
    }
}

enum StorageError: LocalizedError {
    case notFound
    
    var errorDescription: String? {
        switch self {
        case .notFound:
            return "존재하지 않는 Project 입니다."
        }
    }
}
