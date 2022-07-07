//
//  UITextField+extension.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/06.
//

import UIKit

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 20,
                height: self.frame.height
            )
        )
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
