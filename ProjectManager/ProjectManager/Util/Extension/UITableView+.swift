//
//  UITableView+.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/17.
//

import UIKit

extension UITableView {
    
    func dequeueReusableCell<Cell: UITableViewCell>(cellType: Cell.Type, for indexPath: IndexPath) -> Cell
    where Cell: Reusable {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? Cell else {
            return Cell()
        }

        return cell
    }
}
