import Foundation

class DetailAddViewModel: ViewModel {
    
    var useCase: ProjectManagingUseCase
    var coordinator: Coordinator?
    
    init(useCase: ProjectManagingUseCase) {
        self.useCase = useCase
    }
}
