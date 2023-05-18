//
//  CountLabel.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/18.
//

import UIKit

class CountLabel: UILabel {
    let padding = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize

        if contentSize.width > contentSize.height {
            contentSize.width += padding.left + padding.right
            contentSize.height = contentSize.width
        } else {
            contentSize.height += padding.left + padding.right
            contentSize.width = contentSize.height
        }
        
        return contentSize
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        layer.masksToBounds = true
        layer.cornerRadius = bounds.height / 2
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
}
