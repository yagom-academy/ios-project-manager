//
//  UITableView + Extension.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/10.
//

import UIKit

extension UITableView {
    func register(_ cellType: UITableViewCell.Type) {
        self.register(cellType, forCellReuseIdentifier: "\(cellType)")
    }
}
