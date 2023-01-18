//
//  ProjectViewController+KeyboardNotification.swift
//  ProjectManager
//
//  Created by 노유빈 on 2023/01/18.
//

import UIKit

extension ProjectViewController {
    @objc func keyboardWillShow(_ notification: NSNotification){
        if !projectView.isTexting,
           let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height

            projectView.descriptionTextView.contentInset.bottom += keyboardHeight
            projectView.isTexting = true
        }
    }

    @objc func keyboardWillHide(_ notification: NSNotification){
        if projectView.isTexting {
            projectView.descriptionTextView.contentInset.bottom  = 0
            projectView.isTexting = false
        }
    }

    func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
