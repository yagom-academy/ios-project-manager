//
//  UIEdgeInsets+Extension.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/12.
//

import UIKit

extension UIEdgeInsets {
    init(top: CGFloat = .zero) {
        self.init(top: top, left: .zero, bottom: .zero, right: .zero)
    }
}
