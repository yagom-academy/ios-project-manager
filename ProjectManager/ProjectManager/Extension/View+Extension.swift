//
//  View+Extension.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/13.
//

import UIKit

extension UIView {
    func applyShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 3.0
    }
}
