import Foundation
import RxSwift

final class ListViewModel: ViewModel {
    
    let disposeBag = DisposeBag()
    var useCase: ControlUseCase
    var coordinator: Coordinator?
    
    init(useCase: ControlUseCase, coordinator: Coordinator) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
    
    struct Input {
        let viewWillAppearEvent: Observable<Void>
        let projectAddButtonTapped: Observable<Void>
        let projectDeleteEvent: Observable<String>
        let projectDidtappedEvent: Observable<String>
    }

    struct Output {
        let baseProjects: Observable<[Listable]>
    }

    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let output = self.createViewModelOutput()
        
        input.viewWillAppearEvent.subscribe { [weak self] _ in
            self?.useCase.fetch()
        }.disposed(by: disposeBag)
        
        input.projectAddButtonTapped.subscribe { _ in
            self.coordinator?.occuredViewEvent(with: .presentListAddView)
        }.disposed(by: disposeBag)
        
        input.projectDeleteEvent.subscribe { identifer in
            self.useCase.deleteProject(identifier: identifer)
        }.disposed(by: disposeBag)
        
        input.projectDidtappedEvent.subscribe { identifier in
            self.coordinator?.occuredViewEvent(with: .presentListUpdateView(identifier: identifier))
        }.disposed(by: disposeBag)
        
        return output
    }
    
    private func createViewModelOutput() -> Output {
        let initialProjects = useCase.rxLists
            .map { $0 }
            .share(replay: 1)
        
        return Output(baseProjects: initialProjects)
    }
}
