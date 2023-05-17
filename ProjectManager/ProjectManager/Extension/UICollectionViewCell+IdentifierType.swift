//
//  UICollectionViewCell+IdentifierType.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/17.
//

import UIKit

public protocol IdentifierType {}

extension IdentifierType {
    public static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: IdentifierType {}
