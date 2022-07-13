//
//  UIStackView+Extension.swift
//  ProjectManager
//
//  Created by 우롱차 파프리 on 06/07/2022.
//

import Foundation
import UIKit

extension UIStackView {
    func addSubViews(_ views: UIView...) {
        views.forEach { view in
            addArrangedSubview(view)
        }
    }
}
