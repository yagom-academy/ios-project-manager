//
//  IdentifierType.swift
//  ProjectManager
//
//  Created by Hyejeong Jeong on 2023/05/18.
//

import UIKit

protocol IdentifierType { }

extension IdentifierType {
    public static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: IdentifierType { }
