import UIKit
import RxRelay

protocol ViewModel {
    
    var useCase: ControlUseCase { get set }
    var coordinator: Coordinator? { get set }
}
