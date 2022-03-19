import Foundation
import RxSwift
import RxRelay

final class DetailUpdateViewModel {
    
    let controlUseCase: ControlUseCase
    let historyCheckUseCase: HistoryCheckUseCase
    var coordinator: Coordinator?
    let identifer: String
    
    init(controlUseCase: ControlUseCase, historyCheckUseCase: HistoryCheckUseCase, identifier: String) {
        self.controlUseCase = controlUseCase
        self.historyCheckUseCase = historyCheckUseCase
        self.identifer = identifier
    }
    
    struct Input {
        var viewWillAppearEvent: Observable<Void>
    }
    
    struct Output {
        var selectedProjectData: Observable<Listable>
    }
    
    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let output = configureDetailViewModelOutput()
        
        input.viewWillAppearEvent.subscribe(onNext: { _ in
            self.controlUseCase.fetch()
        }).disposed(by: disposeBag)
        
        
        return output
    }
    
    private func configureDetailViewModelOutput() -> Output {
        let list = Observable<Listable>.create { emitter in
            _ = self.controlUseCase.rxLists.map { lists in
                lists.map { $0.identifier == self.identifer ?
                    emitter.onNext($0) : nil
                }
            }
            return Disposables.create {
            }
        }
        return Output(selectedProjectData: list)
    }
}
