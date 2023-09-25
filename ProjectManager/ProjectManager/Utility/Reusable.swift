//
//  Reusable.swift
//  ProjectManager
//
//  Created by Moon on 2023/09/25.
//

import UIKit

protocol Reusable { }

extension Reusable where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable { }
