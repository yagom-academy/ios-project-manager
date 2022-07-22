//
//  UIViewController + Extension.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/22.
//

import UIKit

extension UIViewController {
    func showErrorAlert(messege: String) {
        let alert = UIAlertController(title: "오류", message: messege, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default) { _ in
            self.dismiss(animated: true)
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
}
