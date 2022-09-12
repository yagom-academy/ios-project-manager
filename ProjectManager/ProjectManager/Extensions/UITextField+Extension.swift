//
//  UITextField+Extension.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/09.
//

import UIKit

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 10,
                height: self.frame.height
            )
        )
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
