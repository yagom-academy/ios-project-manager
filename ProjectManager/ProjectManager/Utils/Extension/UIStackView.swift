//
//  UIStackView.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/07.
//

import UIKit

extension UIStackView {
  func addArrangedSubviews(_ views: [UIView]) {
    views.forEach { self.addArrangedSubview($0) }
  }
}
