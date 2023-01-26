//
//  UILabel +.swift
//  ProjectManager
//
//  Created by 맹선아 on 2023/01/13.
//

import UIKit

extension UILabel {
    
    convenience init(font: UIFont.TextStyle = .body,
                     textColor: UIColor = .black,
                     numberOfLines: Int = 0,
                     textAlignment: NSTextAlignment = .natural) {
        self.init(frame: .zero)
        self.font = .preferredFont(forTextStyle: font)
        self.textColor = textColor
        self.numberOfLines = numberOfLines
        self.textAlignment = textAlignment
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
