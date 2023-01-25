//
//  UIAlertController +.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/16.
//

import UIKit

extension UIAlertController {
    
    func makePopoverStyle() {
        self.modalPresentationStyle = .popover
        self.popoverPresentationController?.permittedArrowDirections = .up
    }
}
