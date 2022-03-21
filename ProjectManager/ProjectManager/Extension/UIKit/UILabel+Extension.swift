//
//  UILabel+Extension.swift
//  ProjectManager
//
//  Created by 고은 on 2022/03/05.
//

import UIKit

extension UILabel {

    func circleBadge(count: Int, size: CGFloat) {
        self.text = String(count)
        self.textColor = .white
        self.textAlignment = .center
        self.bounds = CGRect(x: 0, y: 0, width: size, height: size)
        self.layer.cornerRadius = size / 2
        self.layer.backgroundColor = UIColor.black.cgColor
        self.layer.masksToBounds = true
    }
}
