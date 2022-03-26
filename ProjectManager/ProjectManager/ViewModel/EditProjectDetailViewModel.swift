import Foundation
import RxSwift

class EditProjectDetailViewModel: ViewModelType {
    struct Input {
        let didTapDoneButton: Observable<Void>
    }
    
    struct Output {
    
    }
    
    let usecase: ProjectUseCaseProtocol
    let disposeBag = DisposeBag()
    var currentProject: Project
    
    init(usecase: ProjectUseCaseProtocol, currentProject: Project) {
        self.usecase = usecase
        self.currentProject = currentProject
    }
    
    func transform(input: Input) -> Output {
        input.didTapDoneButton
            .subscribe(onNext: { [weak self] in
                self?.usecase.update(self?.currentProject ?? Project(id: UUID(), state: .todo, title: "", body: "", date: Date()), to: nil)
            }).disposed(by: disposeBag)
        
        let output = Output()
        return output
    }
}
