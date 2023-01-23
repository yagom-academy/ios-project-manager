//  ProjectManager - ReusableView.swift
//  created by zhilly on 2023/01/17

import UIKit

protocol ReusableView: UIView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
