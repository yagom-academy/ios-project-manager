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
        let todoProjects: Observable<[Listable]>
        let doingProjects: Observable<[Listable]>
        let doneProjects: Observable<[Listable]>
        let todoCounts: Observable<Int>
        let doingCounts: Observable<Int>
        let doneCounts: Observable<Int>
    }

    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let output = self.createViewModelOutput()
        
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
        let todoProjects = self.controlUseCase.extractDataSourceRelay()
            .map { lists in
                lists.filter { $0.progressState == "todo" }
            }
        let doingProjects = self.controlUseCase.extractDataSourceRelay()
            .map { lists in
                lists.filter { $0.progressState == "doing" }
            }
        let doneProjects = self.controlUseCase.extractDataSourceRelay()
            .map { lists in
                lists.filter { $0.progressState == "done" }
            }
        let todoCounts = todoProjects.map { lists -> Int in
            lists.count
        }
        let doingCounts = doingProjects.map { lists -> Int in
            lists.count
        }
        let doneCounts = doneProjects.map { lists -> Int in
            lists.count
        }
        
        return Output(todoProjects: todoProjects, doingProjects: doingProjects, doneProjects: doneProjects, todoCounts: todoCounts, doingCounts: doingCounts, doneCounts: doneCounts)
    }
}
