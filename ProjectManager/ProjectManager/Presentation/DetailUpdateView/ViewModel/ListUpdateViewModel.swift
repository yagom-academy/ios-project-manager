import Foundation
import RxSwift
import RxRelay

final class ListUpdateViewModel {
    
    let controlUseCase: ControlUseCase
    let historyCheckUseCase: HistoryCheckUseCase
    var coordinator: Coordinator?
    let identifer: String
    let state = BehaviorRelay<ListUpdateViewModelState>(value: .editing)
    var inputedData = PublishSubject<(name: String, detail: String, deadline: Date)>()
    private var listProgressState: String?
    
    init(controlUseCase: ControlUseCase, historyCheckUseCase: HistoryCheckUseCase, identifier: String) {
        self.controlUseCase = controlUseCase
        self.historyCheckUseCase = historyCheckUseCase
        self.identifer = identifier
    }
    
    struct Input {
        
        var viewWillAppearEvent: Observable<Void>
        var doneEdittingEvent: Observable<Void>
        var cancelButtonTapped: Observable<Void>
    }
    
    struct Output {
        
        var selectedProjectData: Observable<Listable>
    }
    
    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let output = self.configureDetailViewModelOutput()
        
        input.viewWillAppearEvent.subscribe(onNext: { _ in
            self.controlUseCase.fetch()
        }).disposed(by: disposeBag)
        
        input.cancelButtonTapped.subscribe(onNext: { _ in
            self.coordinator?.occuredViewEvent(with: .dismissListUpdateView)
        }).disposed(by: disposeBag)
        
        input.doneEdittingEvent.subscribe(onNext: { _ in
            self.state.accept(.done)
            self.coordinator?.occuredViewEvent(with: .dismissListUpdateView)
        }).disposed(by: disposeBag)
        
        self.inputedData.subscribe(onNext: { name, detail, date in
            let changedProject = Project(name: name, detail: detail, deadline: date, indentifier: self.identifer, progressState: self.listProgressState ?? "todo")
            self.controlUseCase.updateProject(identifier: changedProject.identifier, how: changedProject)
        }).disposed(by: disposeBag)
        
        
        return output!
    }
    
    private func configureDetailViewModelOutput() -> Output? {
        
        guard let project = controlUseCase.readProject(identifier: self.identifer)
        else {
            return nil
        }
        
        self.listProgressState = project.progressState
        let list = Observable<Listable>.create { emitter in
            emitter.onNext(project)
            return Disposables.create { }
        }
        
        return Output(selectedProjectData: list)
    }
}
