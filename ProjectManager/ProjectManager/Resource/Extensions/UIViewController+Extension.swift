//
//  UIViewController+Extension.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/29.
//

import UIKit

extension UIViewController {
    func presentErrorAlert(_ error: Error) {
        let errorAlert = UIAlertController(
            title: Alert.errorAlertTitle,
            message: error.localizedDescription,
            preferredStyle: .alert
        )

        let confirmAction = UIAlertAction(
            title: Alert.confirmActionTitle,
            style: .default
        )

        errorAlert.addAction(confirmAction)

        DispatchQueue.main.async { [weak self] in
            self?.present(errorAlert, animated: true)
        }
    }
}
