//
//  AlertManager.swift
//  ProjectManager
//
//  Created by Hyejeong Jeong on 2023/05/23.
//

import UIKit

struct AlertManager {
    func showAlert(target: UIViewController, title: String, message: String, handler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in handler() })
        target.present(alert, animated: true)
    }
}
