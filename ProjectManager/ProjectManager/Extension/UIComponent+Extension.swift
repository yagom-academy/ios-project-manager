//
//  UIComponent+Extension.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/12.
//

import UIKit

extension UILabel {
    convenience init(fontStyle: UIFont.TextStyle) {
        self.init(frame: .zero)
        font = .preferredFont(forTextStyle: fontStyle)
        translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIStackView {
    convenience init(
        views: [UIView],
        axis: NSLayoutConstraint.Axis,
        alignment: Alignment,
        distribution: Distribution,
        spacing: CGFloat = 0
    ) {
        self.init(arrangedSubviews: views)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
        translatesAutoresizingMaskIntoConstraints = false
    }
}
