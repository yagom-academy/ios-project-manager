//
//  CircleLabel.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/15.
//

import UIKit

final class CircleLabel: UILabel {
    
    typealias Style = Constant.Style
    typealias Color = Constant.Color
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += Style.circleViewWidthPadding
        contentSize.height += Style.circleViewHeightPadding
        layer.cornerRadius = contentSize.height.half

        return contentSize
    }
    
    func configure(circleColor: CGColor, textColor: UIColor) {
        self.textColor = textColor
        self.textAlignment = .center
        layer.backgroundColor = circleColor
    }
}
