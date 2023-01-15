//
//  CircleLabel.swift
//  ProjectManager
//
//  Created by Gundy on 2023/01/15.
//

import UIKit

class CircleLabel: UILabel {

    typealias Style = ProjectConstant.Style
    typealias Color = ProjectConstant.Color

    init(circleColor: CGColor = Color.circleBackground,
         textColor: UIColor = Color.circleText,
         frame: CGRect) {
        super.init(frame: frame)
        configure(circleColor: circleColor, textColor: textColor)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        layer.cornerRadius = intrinsicContentSize.height.half
    }

    func configure(circleColor: CGColor, textColor: UIColor) {
        layer.backgroundColor = circleColor
        self.textColor = textColor
        self.textAlignment = .center
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += Style.circleViewWidthPadding
        contentSize.height += Style.circleViewHeightPadding

        return contentSize
    }
}
