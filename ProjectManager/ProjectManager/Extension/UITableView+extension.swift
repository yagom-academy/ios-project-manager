import UIKit


extension UITableView {
    func register<T: UITableViewCell>(_ nib: UINib, cellClass: T.Type) {
        register(nib, forCellReuseIdentifier: String(describing: cellClass))
    }
}
