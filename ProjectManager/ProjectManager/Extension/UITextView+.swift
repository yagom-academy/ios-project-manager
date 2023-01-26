//
//  UITextView+.swift
//  ProjectManager
//
//  Created by sumemrcat on 2023/01/18.
//

import UIKit

extension UITextView {
    func addShadow(
        color: CGColor = UIColor.systemGray.cgColor,
        opacity: Float = 1,
        radius: CGFloat,
        offset: CGSize = CGSize.zero
    ) {
        self.clipsToBounds = false
        self.layer.shadowColor = color
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = offset
    }
}
