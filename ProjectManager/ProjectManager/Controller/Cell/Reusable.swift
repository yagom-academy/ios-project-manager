//
//  Reusable.swift
//  ProjectManager
//
//  Created by 리나 on 2021/03/12.
//

import UIKit

// MARK: - Resuable

protocol Reusable: class {
    static var identifier: String { get }
}

extension Reusable {
    static var identifier: String {
        return String(describing: self)
    }
}

// MARK: - TableView

extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type)
    where T: Reusable {
        self.register(cellType.self, forCellReuseIdentifier: cellType.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T where T: Reusable {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as? T else {
            return UITableViewCell() as! T
        }
        return cell
    }
    
    func register<T: UITableViewHeaderFooterView>(headerFooterViewType: T.Type) where T: Reusable {
        self.register(headerFooterViewType.self, forHeaderFooterViewReuseIdentifier: headerFooterViewType.identifier)
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ viewType: T.Type = T.self) -> T? where T: Reusable {
        guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: viewType.identifier) as? T? else {
            return nil
        }
        return view
    }
}
