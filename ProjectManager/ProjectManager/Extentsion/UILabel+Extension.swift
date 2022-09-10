//
//  UILabel+Extension.swift
//  ProjectManager
//
//  Created by 김동용 on 2022/09/10.
//

import UIKit

extension UILabel {
    func drawCircle() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }
}
