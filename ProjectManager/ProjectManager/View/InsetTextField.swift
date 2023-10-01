//
//  InsetTextField.swift
//  ProjectManager
//
//  Created by Moon on 2023/10/01.
//

import UIKit

final class InsetTextField: UITextField {
    private let inset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: inset)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: inset)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let editingInsets = UIEdgeInsets(
            top: inset.top,
            left: inset.left,
            bottom: inset.bottom,
            right: inset.right
        )
        
        return bounds.inset(by: editingInsets)
    }
}
