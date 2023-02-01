//
//  UIStackView.swift
//  ProjectManager
//
//  Created by Baem on 2023/01/20.
//

import UIKit

extension UIStackView {
    convenience init(
        axis: NSLayoutConstraint.Axis,
        alignment: UIStackView.Alignment,
        distribution: UIStackView.Distribution,
        spacing: CGFloat = 0
    ) {
        self.init()
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
