import UIKit

extension UITableView {
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass: T.Type) -> T {
        guard let headerFooterView = self.dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as? T else {
            return T()
        }
        
        return headerFooterView
    }
    
    func dequeueReusableCell<T: UITableViewCell>(withClass: T.Type) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T else {
            return T()
        }
        
        return cell
    }

    func registerCell<T: UITableViewCell>(withClass: T.Type) {
        self.register(T.self, forCellReuseIdentifier: String(describing: T.self))
    }
    
    func registerHeaderFooterView<T: UITableViewHeaderFooterView>(withClass: T.Type) {
        self.register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: T.self))
    }
}
