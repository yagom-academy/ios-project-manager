//
//  UIViewController + Extension.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/22.
//

import UIKit

extension UIViewController {
    func showErrorAlert(message: String?) {
        let alert = UIAlertController(title: "오류",
                                      message: message ?? "예상치 못한 오류가 발생했습니다. 잠시 후 다시 시도해 주세요",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default) { _ in
            self.dismiss(animated: true)
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
    
    func showExitAlert(message: String) {
        let alert = UIAlertController(title: "",
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default) { _ in
            exit(0)
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
}
