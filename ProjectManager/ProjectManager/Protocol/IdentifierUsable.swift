//
//  IdentifierUsable.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/12.
//

import UIKit

protocol IdentifierUsable where Self: UIView { }

extension IdentifierUsable {
    static var identifier: String {
        return String.init(describing: self)
    }
}
