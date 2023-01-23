//
//  UILabel.swift
//  ProjectManager
//
//  Created by Baem on 2023/01/12.
//

import UIKit

extension UILabel {
    convenience init(fontStyle: UIFont.TextStyle, numberOfLines: Int = 1, textColor: UIColor) {
        self.init()
        self.font = UIFont.preferredFont(forTextStyle: fontStyle)
        self.numberOfLines = numberOfLines
        self.textColor = textColor
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
