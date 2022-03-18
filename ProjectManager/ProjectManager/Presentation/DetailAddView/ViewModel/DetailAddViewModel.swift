import Foundation
import RxSwift
import RxRelay

class DetailAddViewModel: ViewModel {
    
    var useCase: UseCaseProvider
    var coordinator: Coordinator?
    let disposeBag = DisposeBag()
    let state = BehaviorRelay<DetailAddViewModelState>(value: .edit)
    var observableData = PublishSubject<(name: String, detail: String, deadline: Date)>()
    
    init(useCase: UseCaseProvider) {
        self.useCase = useCase
    }
    
    struct Input {
        
        let cancelButtonTappedEvent: Observable<Void>
        let doneButtonTappedEvent: Observable<Void>
    }
    
    func transform(input: Input, disposeBag: DisposeBag) {
        
        input.cancelButtonTappedEvent.subscribe { _ in
            self.coordinator?.occuredEvent(with: .dismissDetailAddView)
            
        }.disposed(by: disposeBag)
        
        input.doneButtonTappedEvent.subscribe { _ in
            self.state.accept(.done)
            self.coordinator?.occuredEvent(with: .dismissDetailAddView)
        }
        .disposed(by: disposeBag)
        
        self.observableData.subscribe { name, detail, deadline in
            let project = Project(name: name, detail: detail, deadline: deadline, indentifier: UUID().uuidString, progressState: ProgressState.todo.description)
            self.useCase.createProject(object: project)
        }.disposed(by: disposeBag)
        
    }
}
