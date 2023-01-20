//
//  UIButton.swift
//  ProjectManager
//
//  Created by Baem on 2023/01/20.
//

import UIKit

extension UIButton {
    convenience init(title: String, titleColor: UIColor) {
        self.init()
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
    }
}
