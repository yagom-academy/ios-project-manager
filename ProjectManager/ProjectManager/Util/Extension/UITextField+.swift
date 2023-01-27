//
//  UITextField+.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/19.
//

import UIKit

extension UITextField {
    
    func setShadow(color: UIColor = .systemBackground,
                   opacity: Float = 0.5,
                   offset: CGSize = CGSize(width: 0, height: 4)) {
        backgroundColor = color
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
    }
}
