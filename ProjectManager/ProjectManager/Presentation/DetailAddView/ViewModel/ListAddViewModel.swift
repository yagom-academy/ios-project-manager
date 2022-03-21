import Foundation
import RxSwift
import RxRelay

final class ListAddViewModel: ViewModel {
    
    var useCase: ControlUseCase
    var coordinator: Coordinator?
    let state = BehaviorRelay<ListAddViewModelState>(value: .editing)
    var inputedData = PublishSubject<(name: String, detail: String, deadline: Date)>()
    private let disposeBag = DisposeBag()
    
    init(useCase: ControlUseCase) {
        self.useCase = useCase
    }
    
    struct Input {
        
        let cancelButtonTappedEvent: Observable<Void>
        let doneButtonTappedEvent: Observable<Void>
    }
    
    func transform(input: Input, disposeBag: DisposeBag) {
        input.cancelButtonTappedEvent.subscribe { _ in
            self.coordinator?.occuredViewEvent(with: .dismissListAddView)
            
        }.disposed(by: disposeBag)
        
        input.doneButtonTappedEvent.subscribe { _ in
            self.state.accept(.done)
            self.coordinator?.occuredViewEvent(with: .dismissListAddView)
        }
        .disposed(by: disposeBag)

        self.inputedData.subscribe { name, detail, deadline in
            let project = Project(name: name, detail: detail, deadline: deadline, indentifier: UUID().uuidString, progressState: ProgressState.todo.description)
            self.useCase.createProject(object: project)
        }.disposed(by: disposeBag)
    }
}
