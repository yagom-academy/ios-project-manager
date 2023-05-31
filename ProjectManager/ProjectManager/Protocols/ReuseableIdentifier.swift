//
//  ReuseableIdentifier.swift
//  ProjectManager
//
//  Created by Rowan, Brody on 2023/05/31.
//

import UIKit
 
protocol ReusableIdentifier: AnyObject {
    static var identifier: String { get }
}

extension ReusableIdentifier where Self: UIView {
    static var identifier: String { return String(describing: self) }
}

extension UICollectionViewCell: ReusableIdentifier { }
extension HeaderView: ReusableIdentifier { }
