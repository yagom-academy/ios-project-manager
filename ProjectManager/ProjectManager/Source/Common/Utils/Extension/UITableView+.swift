//
//  UITableView+.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/20.
//

import UIKit.UITableView

extension UITableView {
    func frameInWindow(cellRowAt indexPath: IndexPath) -> CGRect? {
        guard let cell = cellForRow(at: indexPath) else {
            return nil
        }
        
        return cell.convert(cell.bounds, to: .none)
    }
}
