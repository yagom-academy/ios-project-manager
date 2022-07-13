//
//  PopOverable.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/14.
//

import UIKit

import RxSwift

protocol PopOverable where Self: UIAlertController {
  static func presentPopOver(
    _ viewController: UIViewController?,
    with configuration: AlertConfiguration,
    on sourceView: UIView
  ) -> Observable<Int>
}

// MARK: - Extensions

extension PopOverable {
  static func presentPopOver(
    _ viewController: UIViewController?,
    with configuration: AlertConfiguration,
    on sourceView: UIView
  ) -> Observable<Int> {
    return Single.create { observer in
      let alert = UIAlertController(
        title: configuration.title,
        message: configuration.message,
        preferredStyle: configuration.preferredStyle
      )
      
      let sourceRect = CGRect(x: sourceView.bounds.midX, y: sourceView.bounds.midY, width: 0, height: 0)
      alert.modalPresentationStyle = .popover
      alert.popoverPresentationController?.permittedArrowDirections = .up
      alert.popoverPresentationController?.sourceView = sourceView
      alert.popoverPresentationController?.sourceRect = sourceRect
      
      configuration.actions.enumerated().forEach { index, action in
        let action = UIAlertAction(title: action.title, style: action.style) { _ in
          observer(.success(index))
        }
        alert.addAction(action)
      }
      viewController?.present(alert, animated: true)

      return Disposables.create {
        alert.dismiss(animated: true)
      }
    }.asObservable()
  }
}
