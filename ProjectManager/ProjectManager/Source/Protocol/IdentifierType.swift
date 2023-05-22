//
//  IdentifierType.swift
//  ProjectManager
//
//  Created by songjun, vetto on 2023/05/19.
//

import UIKit

public protocol IdentifierType {
    static var identifier: String { get }
}

extension IdentifierType {
    public static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: IdentifierType {}
extension UIViewController: IdentifierType {}

// 헤더뷰 만들기
