//
//  ProjectViewController+Delegate.swift
//  ProjectManager
//
//  Created by 노유빈 on 2023/01/18.
//

import UIKit

// MARK: descriptionTextView
extension ProjectViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)

        return changedText.count <= 1000
    }
}

// MARK: titleTextField
extension ProjectViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
