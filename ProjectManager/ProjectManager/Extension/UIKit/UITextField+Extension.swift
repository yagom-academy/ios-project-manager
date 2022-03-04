//
//  TextField+Extension.swift
//  ProjectManager
//
//  Created by 고은 on 2022/03/03.
//

import UIKit

extension UITextField {

    func styleWithShadow() {
        self.layer.masksToBounds = false
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.systemGray3.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 1.5
        self.layer.shadowRadius = 3.5
    }
}
