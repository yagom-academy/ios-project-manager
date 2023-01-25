//
//  IdentifierUsable.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/12.
//

import UIKit

protocol Identifierable where Self: UIView { }

extension Identifierable {
    static var identifier: String {
        return String.init(describing: self)
    }
}
