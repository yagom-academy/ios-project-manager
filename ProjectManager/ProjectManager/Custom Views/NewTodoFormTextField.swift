//
//  NewTodoFormTextField.swift
//  ProjectManager
//
//  Created by 김민성 on 2021/07/05.
//

import UIKit

class NewTodoFormTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addPadding()
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
        
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 4
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.5
        
        backgroundColor = .systemBackground
        placeholder = "Title"
    }
    
    private func addPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: frame.size.height))
        
        leftView = paddingView
        rightView = paddingView
        leftViewMode = .always
        rightViewMode = .always
        
    }
}
