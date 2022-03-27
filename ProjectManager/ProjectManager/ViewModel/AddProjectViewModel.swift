import Foundation
import RxSwift

class AddProjectViewModel {
    private let repository: ProjectRepository
    private let viewDismissObserver: PublishSubject<Void> = .init()
    private let disposeBag: DisposeBag = .init()
    
    final class Input {
        let tapAddProjectObserver: Observable<ProjectInput>
        let tapCancelButtonObserver: Observable<Void>
        
        init(tapAddProjectObserver: Observable<ProjectInput>, tapCancelButtonObserver: Observable<Void>) {
            self.tapAddProjectObserver = tapAddProjectObserver
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
            .tapAddProjectObserver
            .subscribe(onNext: { [weak self] projectInput in
                self?.addProject(with: projectInput)
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
    
    private func addProject(with projectInput: ProjectInput) {
        repository.addProject(projectInput: projectInput)
    }
}
