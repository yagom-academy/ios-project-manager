import Foundation
import RxSwift

class MainViewModel {
    
    let useCase: ProjectManagingUseCase
    
    init(useCase: ProjectManagingUseCase) {
        self.useCase = useCase
    }
}
