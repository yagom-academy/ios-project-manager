//
//  UITextView+.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/19.
//

import UIKit

extension UITextView {

    func setShadow(opacity: Float = 0.5,
                   offset: CGSize = CGSize(width: 0, height: 4)) {
        layer.masksToBounds = false
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
    }
}
