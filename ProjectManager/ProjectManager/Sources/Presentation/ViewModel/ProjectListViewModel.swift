import Foundation
import RxSwift

final class ProjectListViewModel {
    private(set) var projects = [Project]()
    private let useCase: ProjectListUseCase
    private let disposeBag = DisposeBag()
    
    init(useCase: ProjectListUseCase = DefaultProjectListUseCase()) {
        self.useCase = useCase
        
        useCase.fetch().subscribe(onNext: { newProjects in
            self.projects = newProjects
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Output
    var errorMessage = PublishSubject<String>()

    // MARK: - Input
    var inserted = PublishSubject<Project>()
    var updated = PublishSubject<IndexPath>()
    var deleted = PublishSubject<IndexPath>()
    
    func add(_ project: Project) {
        useCase.create(project).subscribe(onSuccess: { project in
            self.inserted.onNext(project)
        }).disposed(by: disposeBag)
    }
    
    func update(_ project: Project, indexPath: IndexPath) {
        useCase.update(project)
            .subscribe(onSuccess: { _ in
                self.updated.onNext(indexPath)
            }, onFailure: { error in
                self.errorMessage.onNext(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    func delete(_ indexPath: IndexPath) {
        useCase.delete(projects[safe: indexPath.row])
            .subscribe(onSuccess: { _ in
                self.deleted.onNext(indexPath)
            }, onFailure: { error in
                self.errorMessage.onNext(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}
