//
//  UIAlertController+Extension.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/13.
//

import UIKit

import RxSwift

extension UIAlertController {
  struct AlertAction {
    let title: String
    let style: UIAlertAction.Style = .default
  }
  
  static func present(
    _ presenter: UIViewController,
    title: String? = nil,
    message: String? = nil,
    preferredStyle: UIAlertController.Style = .actionSheet,
    actions: [AlertAction],
    _ block: ((UIAlertController) -> Void)? = nil
  ) -> Observable<Int> {
    return Single.create { observer in
      let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
      block?(alert)
      
      actions.enumerated().forEach { index, action in
        let action = UIAlertAction(title: action.title, style: action.style) { _ in
          observer(.success(index))
        }
        alert.addAction(action)
      }
      presenter.present(alert, animated: true)
      
      return Disposables.create {
        alert.dismiss(animated: true)
      }
    }.asObservable()
  }
}
