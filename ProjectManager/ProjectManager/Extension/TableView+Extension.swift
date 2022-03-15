//
//  TableView+Extension.swift
//  ProjectManager
//
//  Created by 이승재 on 2022/03/08.
//

import UIKit

extension UITableView {

    func register<T: UITableViewCell>(cellWithClass name: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: name))
    }

    func register<T: UITableViewHeaderFooterView>(headerFooterViewClassWith name: T.Type) {
            register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: name))
        }
}
