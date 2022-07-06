//
//  UIStackView.swift
//  ProjectManager
//
//  Created by 조민호 on 2022/07/06.
//

import UIKit

extension UIStackView {
    func addArrangeSubviews(_ views: UIView...) {
        views.forEach {
            addArrangeSubviews($0)
        }
    }
}
