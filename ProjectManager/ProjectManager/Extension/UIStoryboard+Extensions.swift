import Foundation
import UIKit


enum StoryBoard: String {
    
    case main
    case projectTable
    case workForm
    
    var name: String {
        switch self {
        case .main:
            return "Main"
        case .projectTable:
            return "ProjectTableViewController"
        case .workForm:
            return "WorkFormView"
        }
    }
}

extension UIStoryboard {
    
    func instantiate<T: UIViewController>(_ viewController: T.Type) -> T {
        let viewController = instantiateViewController(withIdentifier: String(describing: T.self))
        
        guard let viewController = viewController as? T else {
            fatalError()
        }
        
        return viewController
    }
    
    func instantiate<T: UINavigationController>(_ navigationController: T.Type) -> T {
        let viewController = instantiateViewController(withIdentifier: String(describing: T.self))
        
        guard let viewController = viewController as? T else {
            fatalError()
        }
        
        return viewController
    }
    
}
