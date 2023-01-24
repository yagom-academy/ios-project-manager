//
//  CellReusable.swift
//  ProjectManager
//
//  Created by som on 2023/01/11.
//

import UIKit

protocol CellReusable {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: CellReusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewHeaderFooterView: CellReusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
