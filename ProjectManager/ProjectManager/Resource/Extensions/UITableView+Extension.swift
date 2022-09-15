//
//  UITableView+Extension.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/14.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type) where T: ReusableCell {
        self.register(cellType.self, forCellReuseIdentifier: T.identifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ReusableCell {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue a cell with identifier \(T.identifier) matching Type \(T.self)")
        }

        return cell
    }
}
