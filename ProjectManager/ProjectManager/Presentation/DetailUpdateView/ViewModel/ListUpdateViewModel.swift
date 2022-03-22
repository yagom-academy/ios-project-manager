import Foundation
import RxSwift
import RxRelay

final class ListUpdateViewModel {
    
    typealias UseCase = ListUpdateUseCase & ListReadUseCase
    
    private let identifer: String
    private let controlUseCase: UseCase
    private let historyCheckUseCase: HistoryCheckUseCase
    private var coordinator: Coordinator?
    private var listProgressState: String?
    
    init(controlUseCase: UseCase, historyCheckUseCase: HistoryCheckUseCase, identifier: String, coordinator: Coordinator) {
        self.controlUseCase = controlUseCase
        self.historyCheckUseCase = historyCheckUseCase
        self.identifer = identifier
        self.coordinator = coordinator
    }
    
    struct Input {
        
        var viewWillAppearEvent: Observable<Void>
        var doneEdittingEvent: Observable<Void>
        var cancelButtonTapped: Observable<Void>
        var inputedData: Observable<(name: String, detail: String, deadline: Date)>
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
            self.coordinator?.occuredViewEvent(with: .dismissListUpdateView)
        }).disposed(by: disposeBag)
        
        input.inputedData.subscribe(onNext: { name, detail, date in
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
