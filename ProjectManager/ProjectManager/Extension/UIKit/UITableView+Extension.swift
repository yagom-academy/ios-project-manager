//
//  UITableView+Extension.swift
//  ProjectManager
//
//  Created by 고은 on 2022/03/03.
//

import UIKit

extension UITableView {

    func register<T: UITableViewCell>(cellWithClass name: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: name))
    }

    func register<T: UITableViewHeaderFooterView>(headerFooterViewClassWith name: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }

    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name)) as? T else {
            return T()
        }

        return cell
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(
        withClass name: T.Type
    ) -> T {
        guard let headerFooterView = dequeueReusableHeaderFooterView(
            withIdentifier: String(describing: name)
        ) as? T else {
            return T()
        }
        return headerFooterView
    }
}
