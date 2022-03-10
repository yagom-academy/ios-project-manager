import Foundation
import RxSwift

class TodoListViewModel {
    
    let useCase: ProjectManagingUseCase
    
    init(useCase: ProjectManagingUseCase) {
        self.useCase = useCase
    }
}
