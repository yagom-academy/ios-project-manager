//
//  UITextField+.swift
//  ProjectManager
//
//  Created by summercat on 2023/01/18.
//

import UIKit

extension UITextField {
    func addShadow(color: CGColor = UIColor.systemGray.cgColor, opacity: Float = 1, radius: CGFloat, offset: CGSize = CGSize.zero) {
        self.layer.shadowColor = color
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = offset
    }
}
