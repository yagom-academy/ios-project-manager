//
//  EllipseLabel.swift
//  ProjectManager
//  Created by inho on 2023/01/14.
//

import UIKit

class EllipseLabel: UILabel {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
    }
}
