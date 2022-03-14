import UIKit

protocol Coordinator: AnyObject {
    
    var navigationController: UINavigationController? { get set }
    
    func start()
    
    func occuredEvent(with type: Event)
}
