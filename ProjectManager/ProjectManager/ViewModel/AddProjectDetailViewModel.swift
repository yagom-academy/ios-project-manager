import Foundation
import RxSwift

final class AddProjectDetailViewModel: ViewModelType {
    private let useCase: ProjectUseCaseProtocol?
    private let disposeBag = DisposeBag()
    init(useCase: ProjectUseCaseProtocol) {
        self.useCase = useCase
    }
    
    struct Input {
        let didTapdoneButton: Observable<Void>
        let projectTitle: Observable<String>
        let projectBody: Observable<String>
        let projectDate: Observable<Date>
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        let projectDetail = Observable.combineLatest(input.projectTitle, input.projectBody, input.projectDate)
        
        let create = input.didTapdoneButton.withLatestFrom(projectDetail)
            .map { (title, body, date) in
                return Project(id: UUID(), state: .todo, title: title, body: body, date: date)
            }
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] project in
                self?.useCase?.append(project)
            }).disposed(by: disposeBag)
        
        return Output()
    }
    
    var onAppended: ((Project) -> Void)?
    
    func didTapDoneButton(_ project: Project) {
        onAppended?(project)
    }
}
