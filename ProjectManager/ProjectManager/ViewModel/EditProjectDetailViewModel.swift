import Foundation
import RxSwift

class EditProjectDetailViewModel: ViewModelDescribing {
    final class Input {
        let didTapButtonObserver: Observable<Void>
        
        init(didTapButtonObserver: Observable<Void>) {
            self.didTapButtonObserver = didTapButtonObserver
        }
    }
    
    final class Output {
        let showsFormObserver: Observable<Project>

        init(showsFormObserver: Observable<Project>) {
            self.showsFormObserver = showsFormObserver
        }
    }
    
    let disposeBag = DisposeBag()
    let showsFormObserver: PublishSubject<Project> = .init()
    var currentProject: Project
    var onUpdated: ((Project) -> Void)?
    
    init(currentProject: Project) {
        self.currentProject = currentProject
    }
    
    func didTapDoneButton(_ project: Project) {
//        onUpdated?(project)
    }
    
    func transform(_ input: Input) -> Output {
        input
            .didTapButtonObserver
            .subscribe(onNext: { _ in
                self.showsFormObserver.onNext(self.currentProject)
            }).disposed(by: disposeBag)
        
        let output = Output(showsFormObserver: showsFormObserver.asObservable())
        return output
    }
}
