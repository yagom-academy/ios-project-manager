//
//  UITextField+.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/19.
//

import UIKit

extension UITextField {
    
    typealias Style = Constant.Style

    func setShadow(color: UIColor = .systemBackground,
                   opacity: Float = Style.shadowOpacity,
                   offset: CGSize = Style.shadowOffset) {
        backgroundColor = color
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
    }
}
