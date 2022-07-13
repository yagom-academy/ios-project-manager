//
//  UIAlertController+Extension.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/13.
//

import UIKit

extension UIAlertController: PopOverable {
  struct AlertAction {
    let title: String
    let style: UIAlertAction.Style = .default
  }
  
  struct AlertConfiguration {
    let title: String?
    let message: String?
    let preferredStyle: UIAlertController.Style
    let actions: [AlertAction]
    
    init(
      title: String? = nil,
      message: String? = nil,
      preferredStyle: UIAlertController.Style = .actionSheet,
      actions: [AlertAction]
    ) {
      self.title = title
      self.message = message
      self.preferredStyle = preferredStyle
      self.actions = actions
    }
  }
}

// MARK: - Extensions

extension UIAlertController.AlertConfiguration {
  init(card: Card) {
    let actions = card.cardType.distinguishMenuType
      .map { $0.moveToMenuTitle }
      .map { UIAlertController.AlertAction(title: $0) }
    self.init(actions: actions)
  }
}
