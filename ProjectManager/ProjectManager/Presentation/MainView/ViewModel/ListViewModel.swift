import Foundation
import RxSwift

final class ListViewModel {
    
    typealias UseCase = ListReadUseCase & ListDeleteUseCase
    
    private let disposeBag = DisposeBag()
    private let controlUseCase: UseCase
    private let historyCheckUseCase: HistoryCheckUseCase
    private var coordinator: Coordinator?
    
    init(controlUseCase: UseCase, historyCheckUseCase: HistoryCheckUseCase ,coordinator: Coordinator) {
        self.controlUseCase = controlUseCase
        self.historyCheckUseCase = historyCheckUseCase
        self.coordinator = coordinator
    }
    
    struct Input {
        let viewWillAppearEvent: Observable<Void>
        let projectAddButtonTapped: Observable<Void>
        let projectDeleteEvent: [Observable<String>]
        let projectDidtappedEvent: [Observable<String>]
    }

    struct Output {
        let baseProjects: Observable<[Listable]>
    }

    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let output = self.createViewModelOutput()
        
        input.viewWillAppearEvent.subscribe { [weak self] _ in
            self?.controlUseCase.fetch()
        }.disposed(by: disposeBag)
        
        input.projectAddButtonTapped.subscribe { _ in
            self.coordinator?.occuredViewEvent(with: .presentListAddView)
        }.disposed(by: disposeBag)
        
        input.projectDeleteEvent
            .forEach { $0
            .subscribe { (identifer: String) in
            let projectTodeleted = self.controlUseCase.readProject(identifier: identifer)
            self.controlUseCase.deleteProject(identifier: identifer)
            self.historyCheckUseCase.saveDifference(method: ManageState.delete, identifier: identifer, object: projectTodeleted!)
            }.disposed(by: disposeBag)}
        
        input.projectDidtappedEvent
            .forEach { $0
            .subscribe { identifier in
            self.coordinator?.occuredViewEvent(with: .presentListUpdateView(identifier: identifier))
            }.disposed(by: disposeBag)}
        
        return output
    }
    
    private func createViewModelOutput() -> Output {
//        let initialProjects = controlUseCase.rxLists
//            .map { $0 }
//            .share(replay: 1)
//
        let k = controlUseCase.extractAll()
            .map { $0 }
            .share(replay: 1)
        
        return Output(baseProjects: k)
    }
}
