//
//  TodoTitleTextField.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/18.
//

import UIKit

final class TodoTitleTextField: UITextField {
    
    private let padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureOption()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        
        return rect.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        
        return rect.inset(by: padding)
    }
    
    private func configureOption() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.borderStyle = .roundedRect
        self.placeholder = "Title"
        self.font = .preferredFont(forTextStyle: .title2)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowColor = UIColor.label.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
}
