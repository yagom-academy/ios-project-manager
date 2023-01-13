//
//  EllipseShapeLabel.swift
//  ProjectManager
//
//  Created by 맹선아 on 2023/01/13.
//

import UIKit

class CircleLabel: UILabel {
    
    private var padding = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    init(font: UIFont.TextStyle = .headline,
         textColor: UIColor = .white,
         backgroundColor: UIColor = .black) {
        super.init(frame: .zero)
        self.font = .preferredFont(forTextStyle: font)
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.masksToBounds = true
        layer.cornerRadius = rect.height/2
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
