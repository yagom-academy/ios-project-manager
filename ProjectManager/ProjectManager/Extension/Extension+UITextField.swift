//
//  Extension+UITextField.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/11.
//

import UIKit.UITextField

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
