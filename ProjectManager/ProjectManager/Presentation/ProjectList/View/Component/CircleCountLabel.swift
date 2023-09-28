//
//  CircleCountLabel.swift
//  ProjectManager
//
//  Created by Erick on 2023/09/28.
//

import UIKit

final class CircleCountLabel: UILabel {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.masksToBounds = true
        layer.cornerRadius = rect.height / 2
    }
}
