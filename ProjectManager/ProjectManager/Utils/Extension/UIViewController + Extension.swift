//
//  UIViewController + Extension.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/22.
//

import UIKit

extension UIViewController {
    func showErrorAlert(messege: String?) {
        let alert = UIAlertController(title: "오류",
                                      message: messege ?? "예상치 못한 오류가 발생했습니다. 잠시 후 다시 시도해 주세요",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default) { _ in
            self.dismiss(animated: true)
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
    
    func showNetworkErrorAlert() {
        let alert = UIAlertController(title: "인터넷 연결을 확인해주세요",
                                      message: "어플 최초 실행시 서버와의 연동을 위해 인터넷 연결이 필요합니다.\n연결 확인 후 어플을 다시 실행해주세요.",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default) { _ in
            exit(0)
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
}
