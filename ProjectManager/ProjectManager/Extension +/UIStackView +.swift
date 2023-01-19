//
//  UIStackView +.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/13.
//

import UIKit

extension UIStackView {
    
    convenience init(axis: NSLayoutConstraint.Axis = .horizontal,
                     distribution: UIStackView.Distribution = .fill,
                     alignment: UIStackView.Alignment = .fill,
                     spacing: CGFloat = 0,
                     backgroundColor: UIColor = .systemBackground,
                     margin: CGFloat = .zero,
                     cornerRadius: CGFloat = 0) {
        self.init(frame: .zero)
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
        self.backgroundColor = backgroundColor
        self.layoutMargins = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        self.layer.cornerRadius = cornerRadius
        self.translatesAutoresizingMaskIntoConstraints = false
    
        if layoutMargins != .zero {
            isLayoutMarginsRelativeArrangement = true
        }
    }
}
