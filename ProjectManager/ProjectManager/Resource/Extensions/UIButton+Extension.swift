//
//  UIButton+Extension.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/17.
//

import UIKit

extension UIButton {
    /// This property gets the last word from the button title.
    var lastTitleText: String? {
        guard let text = self.titleLabel?.text else {
            return nil
        }

        var splitedText = text.split(separator: " ").map(String.init)
        
        return splitedText.removeLast()
    }
}
