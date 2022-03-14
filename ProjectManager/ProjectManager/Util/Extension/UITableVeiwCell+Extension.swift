//
//  UITableVeiwCell+Extension.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/08.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewHeaderFooterView>(headerFooterViewClassWith name: T.Type) {
            register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: name))
        }
    
    func register<T: UITableViewCell>(cellWithClass name: T.Type) {
            register(T.self, forCellReuseIdentifier: String(describing: name))
        }
   
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(
        withClass name: T.Type) -> T {
            guard let headerFooterView = dequeueReusableHeaderFooterView(
                withIdentifier: String(describing: name)) as? T else {
                fatalError(
                    "Couldn't find UITableViewHeaderFooterView for \(String(describing: name)), make sure the view is registered with table view")
            }
            return headerFooterView
        }
    
    func dequeueReusableCell<T: UITableViewCell>(
        withClass name: T.Type,
        for indexPath: IndexPath
    ) -> T {
            guard let cell = dequeueReusableCell(
                withIdentifier: String(describing: name),
                for: indexPath
            ) as? T else {
                fatalError(
                    "Couldn't find UITableViewCell for \(String(describing: name)), make sure the cell is registered with table view")
            }
            return cell
        }
}
