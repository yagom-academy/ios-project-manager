import UIKit


extension UITableView {
    
    func register<T: UITableViewCell>(cellClass: T.Type) {
        let nib = UINib(nibName: String(describing: cellClass.self), bundle: nil)
        
        register(nib, forCellReuseIdentifier: String(describing: cellClass))
    }
    
}
