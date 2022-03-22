import Foundation
import RxSwift
import RxRelay

final class ListAddViewModel {
    
    private let disposeBag = DisposeBag()
    private let controlUseCase: ListCreateUseCase
    private let historyCheckUseCase: HistoryCheckUseCase
    private let coordinator: Coordinator?
    
    init(controlUseCase: ListCreateUseCase, historyCheckUseCase: HistoryCheckUseCase, coordinator: Coordinator) {
        self.controlUseCase = controlUseCase
        self.historyCheckUseCase = historyCheckUseCase
        self.coordinator = coordinator
    }
    
    struct Input {
        
        let cancelButtonTappedEvent: Observable<Void>
        let doneButtonTappedEvent: Observable<Void>
        let inputedData: Observable<(name: String, detail: String, deadline: Date)>
    }
    
    func transform(input: Input, disposeBag: DisposeBag) {
        input.cancelButtonTappedEvent.withUnretained(self).subscribe { (self, void) in
            self.coordinator?.occuredViewEvent(with: .dismissListAddView)
            
        }.disposed(by: disposeBag)
        
        input.doneButtonTappedEvent.withUnretained(self).subscribe { (self, void ) in
            self.coordinator?.occuredViewEvent(with: .dismissListAddView)
        }
        .disposed(by: disposeBag)
        
        input.inputedData.withUnretained(self).subscribe { (self, data) in
            let project = Project(name: data.name, detail: data.detail, deadline: data.deadline, indentifier: UUID().uuidString, progressState: ProgressState.todo.description)
            self.controlUseCase.createProject(object: project)
        }.disposed(by: disposeBag)
    }
}
