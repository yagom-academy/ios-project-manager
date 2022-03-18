import UIKit
import RxRelay

protocol ViewModel {
    
    var useCase: UseCaseProvider { get set }
    var coordinator: Coordinator? { get set }
}
