//
//  ItemCountLabel.swift
//  ProjectManager
//
//  Created by junho lee on 2023/01/14.
//

import UIKit

class ItemCountLabel: UILabel {
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = ProjectColor.itemCountLabelFontColor.color
        self.font = UIFont.preferredFont(forTextStyle: .body)
        self.adjustsFontForContentSizeCategory = true
        self.textAlignment = .center
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let height = bounds.height
        let width = bounds.width
        context.setFillColor(ProjectColor.itemCountLabelCircleColor.color.cgColor)
        context.addArc(center: CGPoint(x: width * 0.5,
                                       y: height * 0.5),
                       radius: width * 0.45,
                       startAngle: 0,
                       endAngle: .pi * 2,
                       clockwise: true)
        context.addArc(center: CGPoint(x: width * 0.5,
                                       y: height * 0.5),
                       radius: width * 0.45,
                       startAngle: .pi * 2,
                       endAngle: 0,
                       clockwise: false)
        context.drawPath(using: .fillStroke)
        super.draw(rect)
    }

}
