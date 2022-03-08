import Foundation
import RxSwift

class TodoListViewModel {
    
    let useCase: CRUDUseCase
    
    init(useCase: CRUDUseCase) {
        self.useCase = useCase
    }
}
