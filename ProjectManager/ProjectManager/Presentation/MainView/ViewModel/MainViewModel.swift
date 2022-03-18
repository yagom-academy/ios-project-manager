import Foundation
import RxSwift

final class MainViewModel: ViewModel {
    
    let disposeBag = DisposeBag()
    var useCase: UseCaseProvider
    var coordinator: Coordinator?
//    let cellData = Driver<Listable>
    
    init(useCase: UseCaseProvider, coordinator: Coordinator) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
    
    func sortData() {
        let data = useCase.sortProjectProgressState(state: .todo)
    }
    
    struct Input {
        let viewWillAppearEvent: Observable<Void>
        let addActionTappedEvent: Observable<Void>
    }

    struct Output {
        let intialListables: Observable<[Listable]>
    }

    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let output = self.createViewModelOutput()
        
        input.viewWillAppearEvent.subscribe { [weak self] _ in
            self?.useCase.fetch()
#if DEBUG
            print("불림")
#endif
        }.disposed(by: disposeBag)
        
        input.addActionTappedEvent.subscribe { _ in
            self.coordinator?.occuredEvent(with: .presentDetailAddView)
        }.disposed(by: disposeBag)
        
        return output
    }
    
    private func createViewModelOutput() -> Output {
        let initialProjects = useCase.rxLists.map { $0 }
        return Output(intialListables: initialProjects)
    }
}
