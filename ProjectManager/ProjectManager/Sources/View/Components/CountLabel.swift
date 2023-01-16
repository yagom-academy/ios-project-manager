//
//  CountLabel.swift
//  ProjectManager
//
//  Created by Wonbi on 2023/01/12.
//

import UIKit

final class CountLabel: UILabel {
    private let padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.masksToBounds = true
        layer.cornerRadius = rect.height / 2
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
}
