//
//  CALayer+.swift
//  ProjectManager
//
//  Created by Hyejeong Jeong on 2023/05/19.
//

import UIKit

extension CALayer {
    func drawBorder(color: UIColor, width: CGFloat) {
        let border = CALayer()
        
        border.name = "BottomBorder"
        border.frame = CGRect.init(x: 0, y: frame.height, width: frame.width, height: width)
        border.backgroundColor = color.cgColor
        self.addSublayer(border)
    }
}
