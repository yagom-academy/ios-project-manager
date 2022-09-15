//
//  Extension+UIView.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/14.
//

import UIKit

extension UIView {
    func appendShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 5.0
    }
}
