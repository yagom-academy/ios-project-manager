//
//  UIButton+Extension.swift
//  ProjectManager
//
//  Created by dhoney96 on 2022/09/17.
//

import UIKit

extension UIButton {
    var lastTitleText: String? {
        guard let text = self.titleLabel?.text else {
            return nil
        }
        
        var splitedText = text.split(separator: " ").map {
            String($0)
        }
        
        return splitedText.removeLast()
    }
}
