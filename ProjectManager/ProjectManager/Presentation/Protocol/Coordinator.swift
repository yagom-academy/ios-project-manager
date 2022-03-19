import UIKit

protocol Coordinator: AnyObject {
    
    var navigationController: UINavigationController? { get set }
    
    func start()
    
    func occuredViewEvent(with type: Event.View)
    
    func occuredRepositoryChangeEvent(with type: Event.NetWork)
}
