//
//  CALayer+Extensions.swift
//  ProjectManager
//
//  Created by Derrick kim on 9/11/22.
//

import UIKit

extension CALayer {
    func addBottomBorder() {
        let border = CALayer()
        border.backgroundColor = UIColor.systemGray6.cgColor
        border.frame = CGRect(x: 0,
                              y: frame.height,
                              width: frame.width,
                              height: 10)
        
        addSublayer(border)
    }
}
