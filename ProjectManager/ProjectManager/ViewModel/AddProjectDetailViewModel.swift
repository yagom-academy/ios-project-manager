import Foundation
import RxSwift

final class AddProjectDetailViewModel: ViewModelDescribing {
    final class Input {
        let didTapDoneButtonObservable: Observable<Project>
        
        init(didTapDoneButtonObservable: Observable<Project>) {
            self.didTapDoneButtonObservable = didTapDoneButtonObservable
        }
    }
    
    final class Output {
        let appendObservable: Observable<Project>
        
        init(appendObservable: Observable<Project>) {
            self.appendObservable = appendObservable
        }
    }
    
    private let disposeBag = DisposeBag()
    private let appendObservable = PublishSubject<Project>()
    
    func transform(_ input: Input) -> Output {
        input
            .didTapDoneButtonObservable
            .subscribe(onNext: { [weak self] project in
                self?.appendObservable.onNext(project)
            }).disposed(by: disposeBag)
        
        let output = Output(appendObservable: appendObservable.asObservable())
        
        return output
    }
}
