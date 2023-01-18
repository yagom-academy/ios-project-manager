//
//  PaddedTextField.swift
//  ProjectManager
//
//  Created by summercat on 2023/01/18.
//

import UIKit

class PaddedTextField: UITextField {
    var padding = UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect = .zero, padding: UIEdgeInsets) {
        self.init(frame: frame)
        self.padding = padding
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
