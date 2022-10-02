//
//  AlertManager.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/26.
//

import UIKit

struct AlertManager {
    func showAlert(_ controller: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "확인", style: .cancel))
        controller.present(alert, animated: true)
    }
}
