//
//  AlertPresentable.swift
//  ProjectManager
//
//  Created by Dragon on 2023/01/26.
//

import UIKit

protocol AlertPresentable: UIViewController {
    func createActionSheet(title: String?, message: String?) -> UIAlertController
    func createAlertAction(title: String?, completion: @escaping () -> Void) -> UIAlertAction
}

extension AlertPresentable {
    func createActionSheet(title: String?, message: String?) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    }
    
    func createAlertAction(title: String?, completion: @escaping () -> Void) -> UIAlertAction {
        return UIAlertAction(title: title, style: .default) { _ in
            completion()
        }
    }
}
