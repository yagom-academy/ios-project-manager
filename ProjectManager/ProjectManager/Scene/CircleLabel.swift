//
//  CircleLabel.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 2022/07/08.
//
import UIKit

class CircleLabel: UILabel {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.masksToBounds = true
        layer.cornerRadius = layer.frame.height/2
    }
}
