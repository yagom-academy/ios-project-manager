//
//  UITextField +.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/13.
//

import UIKit

extension UITextField {
    
    convenience init(font: UIFont.TextStyle = .body, placeHolder: String = "") {
        self.init(frame: .zero)
        self.font = .preferredFont(forTextStyle: font)
        self.placeholder = placeHolder
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addPadding(width: CGFloat) {
        let view = UIView(frame: CGRect(origin: .zero,
                                        size: CGSize(width: width, height: self.frame.height)))
        
        leftView = view
        leftViewMode = .always
    }
    
    func addShadow(backGroundColor: UIColor, shadowColor: UIColor) {
        backgroundColor = backGroundColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 0.3
        layer.shadowOffset = CGSize(width: 1, height: 3)
        layer.shadowColor = shadowColor.cgColor
    }
}
