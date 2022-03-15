import UIKit

protocol Coordinator {
    var parentCoordinateor: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    var type: CoordinatorType { get set }
}

enum CoordinatorType {
    case main
    case datil
}
