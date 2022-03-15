//
//  UIView+Extension.swift
//  ProjectManager
//
//  Created by Lee Seung-Jae on 2022/03/12.
//

import UIKit

extension UIView {

    func shadow() {
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.systemGray4.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 1

        self.layer.shadowColor = UIColor.systemGray.cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 2
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
    }

    func weakShadow() {
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 1

        self.layer.shadowColor = UIColor.systemGray.cgColor
        self.layer.shadowOpacity = 0.6
        self.layer.shadowRadius = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0.5)
    }
}
