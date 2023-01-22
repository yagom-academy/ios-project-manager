//
//  UITextView +.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/13.
//

import UIKit

extension UITextView {
    
    convenience init(font: UIFont.TextStyle = .body) {
        self.init(frame: .zero)
        self.font = .preferredFont(forTextStyle: font)
        layer.borderColor = UIColor.systemGray2.cgColor
        layer.borderWidth = 0.5
        translatesAutoresizingMaskIntoConstraints = false
    }
}
