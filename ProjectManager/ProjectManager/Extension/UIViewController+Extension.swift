//
//  UIViewController+Extension.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/31.
//

import UIKit

extension UIViewController {
    func showErrorAlert(_ error: Error) {
        let alertController = UIAlertController(title: error.localizedDescription,
                                                message: nil,
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "확인", style: .cancel)
        
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}
