import Foundation
import RxSwift

final class AddProjectDetailViewModel: ViewModelType {
    struct Input {
        let didTapdoneButton: Observable<Void>
        let projectTitle: Observable<String>
        let projectBody: Observable<String>
        let projectDate: Observable<Date>
    }
    
    struct Output {}
    
    private let useCase: ProjectUseCaseProtocol?
    private let disposeBag = DisposeBag()
    
    init(useCase: ProjectUseCaseProtocol) {
        self.useCase = useCase
    }

    func transform(input: Input) -> Output {
        let projectDetail = Observable.combineLatest(input.projectTitle, input.projectBody, input.projectDate)
        
        input.didTapdoneButton.withLatestFrom(projectDetail)
            .map { (title, body, date) in
                return Project(id: UUID(), state: .todo, title: title, body: body, date: date)
            }
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] project in
                self?.useCase?.append(project)
            }).disposed(by: disposeBag)
        
        return Output()
    }
}
