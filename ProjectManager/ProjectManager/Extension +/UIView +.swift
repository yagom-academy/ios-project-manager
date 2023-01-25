//
//  UIView +.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/13.
//

import UIKit

extension UIView {
    
    convenience init(backgroundColor: UIColor? = .clear) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        translatesAutoresizingMaskIntoConstraints = false
    }
}
