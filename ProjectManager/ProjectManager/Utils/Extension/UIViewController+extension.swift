//
//  UIViewController+extension.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/14.
//

import UIKit

extension UIViewController {
    func showAlert(message: String) {
        let alertController = UIAlertController(
            title: AppConstants.errorAlertTitle,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: AppConstants.okActionTitle,
            style: .default
        )
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
}
