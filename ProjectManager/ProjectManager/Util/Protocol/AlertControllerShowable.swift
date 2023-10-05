//
//  AlertControllerShowable.swift
//  ProjectManager
//
//  Created by Hyungmin Lee on 2023/10/05.
//

import UIKit

protocol AlertControllerShowable where Self: UIViewController {
    func showPopOverAlertController(sourceRect: CGRect, alertActions: [UIAlertAction])
}

extension AlertControllerShowable {
    func showPopOverAlertController(sourceRect: CGRect, alertActions: [UIAlertAction]) {
        let alertViewController = UIAlertController()
        let popoverController = alertViewController.popoverPresentationController
        
        popoverController?.sourceView = self.view
        popoverController?.sourceRect = CGRect(x: sourceRect.midX,
                                               y: sourceRect.midY,
                                              width: 0,
                                              height: 0)
        popoverController?.permittedArrowDirections = [.up, .down, .left, .right]
        alertActions.forEach {
            alertViewController.addAction($0)
        }
        
        present(alertViewController, animated: true)
    }
}
