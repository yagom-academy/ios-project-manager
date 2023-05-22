//
//  CountLabel.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/18.
//

import UIKit

class CountLabel: UILabel {
    private let padding: CGFloat = 4

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize

        if contentSize.width > contentSize.height {
            contentSize.width += padding
            contentSize.height = contentSize.width
        } else {
            contentSize.height += padding
            contentSize.width = contentSize.height
        }
        
        return contentSize
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        layer.cornerRadius = bounds.height / 2
    }
}
