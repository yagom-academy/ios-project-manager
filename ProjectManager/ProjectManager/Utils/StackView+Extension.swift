//
//  StackView+.swift
//  ProjectManager
//
//  Created by Eddy on 2022/07/06.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(with views: [UIView]) {
        views.forEach {
            self.addArrangedSubview($0)
        }
    }
}
