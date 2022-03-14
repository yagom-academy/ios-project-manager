import Foundation
import RxSwift

class MainViewModel: ViewModel {    
    
    var useCase: ProjectManagingUseCase
    var coordinator: Coordinator?
    
    init(useCase: ProjectManagingUseCase, coordinator: Coordinator) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
    
    func viewWillAppear() {
        let todo = useCase.sortProjectProgressState(state: ProgressState.todo)
      
    }
}
