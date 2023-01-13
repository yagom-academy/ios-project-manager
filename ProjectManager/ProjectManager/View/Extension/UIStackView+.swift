//
//  UIStackView+.swift
//  ProjectManager
//
//  Created by 맹선아 on 2023/01/13.
//

import UIKit

extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis = .horizontal,
                     distribution: UIStackView.Distribution = .fill,
                     alignment: UIStackView.Alignment = .fill,
                     spacing: CGFloat = 0) {
        self.init(frame: .zero)
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
        translatesAutoresizingMaskIntoConstraints = false
    }
}
