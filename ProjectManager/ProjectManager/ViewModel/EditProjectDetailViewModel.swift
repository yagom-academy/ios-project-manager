import Foundation
import RxSwift

class EditProjectDetailViewModel: ViewModelDescribing {
    final class Input {
        let didTapDoneButtonObservable: Observable<Void>
        
        init(didTapDoneButtonObservable: Observable<Void>) {
            self.didTapDoneButtonObservable = didTapDoneButtonObservable
        }
    }
    
    final class Output {
        let updateObservable: Observable<Project>

        init(updateObservable: Observable<Project>) {
            self.updateObservable = updateObservable
        }
    }
    
    var currentProject: Project
    
    init(currentProject: Project) {
        self.currentProject = currentProject
    }
    
    private let disposeBag = DisposeBag()
    private let updateObservable: PublishSubject<Project> = .init()
    
    func transform(_ input: Input) -> Output {
        input
            .didTapDoneButtonObservable
            .subscribe(onNext: { [weak self] _ in
                self?.updateObservable.onNext(self?.currentProject)
            }).disposed(by: disposeBag)
        
        let output = Output(updateObservable: updateObservable.asObservable())
        return output
    }
}
