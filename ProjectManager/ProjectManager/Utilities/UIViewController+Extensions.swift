//
//  UIViewController+Extensions.swift
//  ProjectManager
//
//  Created by Derrick kim on 2022/09/28.
//

import UIKit

extension UIViewController {
    func presentAlertConfirmAction(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "확인",
                                      style: .default,
                                      handler: nil)
        alert.addAction(alertAction)

        self.present(alert,
                     animated: true)
    }
}
