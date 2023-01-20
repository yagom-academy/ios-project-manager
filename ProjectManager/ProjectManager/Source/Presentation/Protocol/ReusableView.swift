//
//  ReusableView.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/20.
//

import UIKit.UIView

protocol ReusableView: UIView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
