//
//  UITableView+dequeue.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/09.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(cellWithClass name: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: name))
    }
    
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("cell dequeue failed")
        }
        
        return cell
    }
}
