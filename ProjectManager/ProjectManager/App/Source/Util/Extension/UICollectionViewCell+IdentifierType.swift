//
//  UICollectionViewCell+ReuseIdentifying.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/17.
//

import UIKit

public protocol ReuseIdentifying {}

extension ReuseIdentifying {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReuseIdentifying {}
