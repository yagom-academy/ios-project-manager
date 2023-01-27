//
//  CircleLabel.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/15.
//

import UIKit

final class CircleLabel: UILabel {
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += 16
        contentSize.height += 4
        layer.cornerRadius = contentSize.height.half

        return contentSize
    }
    
    func configure(circleColor: CGColor, textColor: UIColor) {
        self.textColor = textColor
        self.textAlignment = .center
        layer.backgroundColor = circleColor
    }
}
