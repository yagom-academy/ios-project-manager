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
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addShadow(backGroundColor: UIColor, shadowColor: UIColor) {
        backgroundColor = backGroundColor
        clipsToBounds = false
        layer.borderColor = UIColor.systemGray2.cgColor
        layer.borderWidth = 0.5
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 0.3
        layer.shadowOffset = CGSize(width: 1, height: 4)
        layer.shadowColor = shadowColor.cgColor
    }
}
