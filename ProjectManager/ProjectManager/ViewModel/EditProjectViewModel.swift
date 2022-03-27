import Foundation
import RxSwift

class EditProjectViewModel {
    private let repository: ProjectRepository
    private let viewDismissObserver: PublishSubject<Void> = .init()
    private let disposeBag: DisposeBag = .init()
    
    final class Input {
        let tapEditProjectObserver: Observable<ProjectInput>
        let tapCancelButtonObserver: Observable<Void>
        
        init(tapEditProjectObserver: Observable<ProjectInput>, tapCancelButtonObserver: Observable<Void>) {
            self.tapEditProjectObserver = tapEditProjectObserver
            self.tapCancelButtonObserver = tapCancelButtonObserver
        }
    }
    
    final class Output {
        let viewDismissObserver: Observable<Void>
        
        init(viewDismissObserver: Observable<Void>) {
            self.viewDismissObserver = viewDismissObserver
        }
    }
        
    init(repository: ProjectRepository) {
        self.repository = repository
    }
    
    func transform(_ input: Input) -> Output {
        input
            .tapEditProjectObserver
            .subscribe(onNext: { [weak self] projectInput in
                self?.editProject(with: projectInput)
                self?.viewDismissObserver.onNext(())
            })
            .disposed(by: disposeBag)
        
        input
            .tapCancelButtonObserver
            .subscribe(onNext: { [weak self] in
                self?.viewDismissObserver.onNext(())
            })
            .disposed(by: disposeBag)
        
        let output = Output(viewDismissObserver: self.viewDismissObserver.asObserver())
        
        return output
    }
    
    private func editProject(with projectInput: ProjectInput) {
        repository.editProject(with: projectInput)
    }
}
