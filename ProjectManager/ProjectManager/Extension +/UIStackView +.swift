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
                     backgroundColor: UIColor = .systemBackground) {
        self.init(frame: .zero)
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
        self.backgroundColor = backgroundColor
        self.layoutMargins = layoutMargins
        translatesAutoresizingMaskIntoConstraints = false
    }
}
