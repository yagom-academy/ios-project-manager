import Foundation
import RxSwift
import RxRelay

final class ListAddViewModel {
    
    let state = BehaviorRelay<ListAddViewModelState>(value: .editing)
    var inputedData = PublishSubject<(name: String, detail: String, deadline: Date)>()
    private let disposeBag = DisposeBag()
    private let controlUseCase: ControlUseCase
    private let historyCheckUseCase: HistoryCheckUseCase
    private let coordinator: Coordinator?
    
    init(controlUseCase: ControlUseCase, historyCheckUseCase: HistoryCheckUseCase, coordinator: Coordinator) {
        self.controlUseCase = controlUseCase
        self.historyCheckUseCase = historyCheckUseCase
        self.coordinator = coordinator
    }
    
    struct Input {
        
        let cancelButtonTappedEvent: Observable<Void>
        let doneButtonTappedEvent: Observable<Void>
    }
    
    func transform(input: Input, disposeBag: DisposeBag) {
        input.cancelButtonTappedEvent.withUnretained(self).subscribe { (self, void) in
            self.coordinator?.occuredViewEvent(with: .dismissListAddView)
            
        }.disposed(by: disposeBag)
        
        input.doneButtonTappedEvent.withUnretained(self).subscribe { (self, void ) in
            self.state.accept(.done)
            self.coordinator?.occuredViewEvent(with: .dismissListAddView)
        }
        .disposed(by: disposeBag)

        self.inputedData.subscribe { name, detail, deadline in
            let project = Project(name: name, detail: detail, deadline: deadline, indentifier: UUID().uuidString, progressState: ProgressState.todo.description)
            self.controlUseCase.createProject(object: project)
        }.disposed(by: disposeBag)
    }
}
