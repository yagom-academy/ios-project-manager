//
//  UITextView+.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/19.
//

import UIKit

extension UITextView {

    typealias Style = Constant.Style

    func setShadow(opacity: Float = Style.shadowOpacity,
                   offset: CGSize = Style.shadowOffset) {
        layer.masksToBounds = false
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
    }
}
