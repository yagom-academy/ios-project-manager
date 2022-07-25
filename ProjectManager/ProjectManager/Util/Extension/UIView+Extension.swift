//
//  UIView+Extension.swift
//  ProjectManager
//
//  Created by Minseong on 2022/07/13.
//

import UIKit

extension UIView {
  func shadow(
    borderWidth: CGFloat = 1,
    borderColor: CGColor = UIColor.systemGray5.cgColor,
    shadowColor: CGColor,
    shadowOffset: CGSize,
    shadowOpacity: Float
  ) {
    self.layer.masksToBounds = false
    self.layer.borderWidth = borderWidth
    self.layer.borderColor = borderColor
    self.layer.shadowColor = shadowColor
    self.layer.shadowOffset = shadowOffset
    self.layer.shadowOpacity = shadowOpacity
  }
}
