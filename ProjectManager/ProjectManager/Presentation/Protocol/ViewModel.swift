import UIKit

protocol ViewModel {
    
    var useCase: ProjectManagingUseCase { get set }
    var coordinator: Coordinator? { get set }
}
